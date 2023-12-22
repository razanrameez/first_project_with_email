// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables, unused_field, prefer_final_fields, unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously, avoid_unnecessary_containers, unrelated_type_equality_checks, sized_box_for_whitespace, body_might_complete_normally_nullable, unnecessary_null_comparison, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/Api/sms.dart';
import 'package:firstproject/screens/register/sign_up_otp.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SignUp_Mobile_Number extends StatefulWidget {
  SignUp_Mobile_Number({super.key});

  @override
  State<SignUp_Mobile_Number> createState() => _SignUp_Mobile_NumberState();
}

class _SignUp_Mobile_NumberState extends State<SignUp_Mobile_Number> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _mobileNumber = TextEditingController();

  String phonenumber = "";
   var isPhoneNumberValid = true;

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

      
    }else{
    try {
      // take a data from firbase
     final firbasedata= await FirebaseFirestore.instance.collection('user').where('mobilenumber',isEqualTo:_mobileNumber.text ).get();
     var data=firbasedata.docs;
     if(data.length>=1){

            var snackBar = SnackBar(
          content: Text("user already registered !"),
          backgroundColor: Color.fromARGB(255, 49, 1, 6),
          
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
return;
     }
      final expiretime=DateTime.now().millisecondsSinceEpoch + 120000;
      String otpStoring=randum(); 
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("mobilenumber", phonenumber);
      await prefs.setString("otpverification",otpStoring);
      await prefs.setString("otpExpire", expiretime.toString());
      final String? username = prefs.getString('username');
      
      sendSignupOtp(phonenumber, "$username", int.parse(otpStoring));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Sign_up_otp(_mobileNumber.text, phoneNumber: _mobileNumber.text,),
          ));
    } catch (e) {
      print(e);
    }}
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
