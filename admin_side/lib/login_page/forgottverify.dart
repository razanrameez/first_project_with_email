// ignore_for_file: camel_case_types, unused_field, prefer_final_fields, unused_element, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, unused_local_variable, avoid_print, prefer_is_empty, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forgot_verify extends StatefulWidget {
  final mobileNumber;

  const Forgot_verify(String text, {this.mobileNumber});

  @override
  State<Forgot_verify> createState() => _Forgot_verifyState();
}

class _Forgot_verifyState extends State<Forgot_verify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _otpverify = GlobalKey<FormState>();
  TextEditingController _otpconfirmation = TextEditingController();
  TextEditingController _enternewpassword = TextEditingController();
  TextEditingController _enterconfirmpassword = TextEditingController();

  String _newpassord = "";
  String _confirmpassword = "";
  bool isotpVerify = false;

  void _forgott() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final dynamic otpStored = prefs.getString('otpverification');
      final dynamic phone = prefs.getString("mobilenumber");
      await prefs.setString('password', _newpassord);
      var data = await FirebaseFirestore.instance.collection("user").where("mobilenumber", isEqualTo: phone).get();
      var docs= data.docs;
      var email=data.docs.first.get('email');
      print(email);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (data.docs.length >= 1) {
        var userData = data.docs[0].reference;
        await userData.update({"password": _newpassord});
        print("Update success");
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e);
    }
  }
  

  void otpVeification() async{
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final dynamic otpStored = prefs.getString('otpverification');
      await prefs.setString('newpassword', _newpassord);
      await prefs.setString('confirmpassword', _confirmpassword);
      print("Stored OTP is $otpStored & entered OTP is ${_otpconfirmation.text}");
       // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => SignUp_Mobile_Number()));
      if (_otpconfirmation.text == otpStored) {
        setState(() {
          isotpVerify = true;
        });

            var snackBar = SnackBar(
          content: Text("OTP verified success "),
          backgroundColor: Color.fromARGB(255, 3, 48, 7),
          
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print("Error : $e");
      
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          SizedBox(
            height: 100,
          ),
          Text(
            "Forgott password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 140,
          ),
          Form(
            key: _otpverify,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _otpconfirmation,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 5, top: 1, bottom: 1),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_otpverify.currentState != null) {
                                  if (_otpverify.currentState!.validate()) {
                                    otpVeification();
                                  }
                                }
                              },
                              child: Text("verify")),
                        ),
                        border: OutlineInputBorder(),
                        labelText: "enter otp"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                         var snackBar = SnackBar(
        content: Text("Incorrect OTP"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _enternewpassword,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "enter new password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter new password";
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _enterconfirmpassword,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: " confirm password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter confirm  password";
                  }else if(_enternewpassword.text!=value){
                    return "confirm password not matched";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (isotpVerify) {
                      if (_formKey.currentState != null) {
                        if (_formKey.currentState!.validate()) {
                          _forgott();
                        }
                      }
                    } else {
                    var snackBar = SnackBar(
        content: Text("please Verify otp"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text("Submit"))
            ]),
          )
        ],
      ),
    ));
  }
}
