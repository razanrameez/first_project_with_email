// ignore_for_file: prefer_const_constructors, camel_case_types, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print, unused_local_variable, use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:math';

import 'package:admin_side/login_page/forgottverify.dart';
import 'package:admin_side/sms/sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forgot_number extends StatefulWidget {
  const Forgot_number({super.key});

  @override
  State<Forgot_number> createState() => _Forgot_numberState();
}

class _Forgot_numberState extends State<Forgot_number> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isPhoneNumberValid = true;

  TextEditingController _mobileNumber = TextEditingController();
  
  var phonenumber;
  String randum() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 4; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    if (rndnumber.startsWith("0")) {
      rndnumber = '1' + rndnumber.substring(1);
    }
    print(rndnumber);
    return rndnumber;
  }

  void enterdMobileNumber() async {
    if (phonenumber == null || phonenumber == "") {
      setState(() {
        isPhoneNumberValid = false;
      });


    } else {
      try {
        final firbasedata= await FirebaseFirestore.instance.collection('user').where('mobilenumber',isEqualTo: _mobileNumber.text).get();
        var data = firbasedata.docs;
        print(data);
        if (data.length==1) {
          print(phonenumber);
        String otpStoring = randum();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("mobilenumber", _mobileNumber.text);
  
        await prefs.setString("otpverification", otpStoring);

        final String? username = prefs.getString('username');
        print("Phone number is ${_mobileNumber.text}");
        sendSignupOtp(phonenumber, "user", int.parse(otpStoring));
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Forgot_verify(_mobileNumber.text)));
        }else{
             var snackBar = SnackBar(
          content: Text("user not found"),
          backgroundColor: Color.fromARGB(255, 119, 0, 0),
          
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        
      } catch (e) {
        print(e);
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Verify Your  mobile number",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 120,
                ),
                
                IntlPhoneField(
                  controller: _mobileNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: isPhoneNumberValid
                        ? null
                        : "Please enter valid phone number",
                        
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {

                    setState(() {
                      phonenumber = phone.number;
                    });
                    
                    print(phone.number);
                  },
                  validator: (value) {
                    if (value == null) {
                      return " please enter a valid number";
                    } else if (_mobileNumber.text.length < 10) {
                      return " phone number should be 10  ";
                    }
                  },
                ),
                SizedBox(height: 20),
                Container(
                    height: 45,
                    width: 400,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              enterdMobileNumber();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text("Send OTP"))),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
