// ignore_for_file: avoid_print, empty_catches, annotate_overrides, prefer_const_constructors, non_constant_identifier_names, camel_case_types, must_be_immutable, use_build_context_synchronously, unnecessary_new, avoid_unnecessary_containers

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/Api/sms.dart';
import 'package:firstproject/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sign_up_otp extends StatefulWidget {
  String phoneNumber = "";
  Sign_up_otp(String phonenumber, {super.key, required this.phoneNumber});

  @override
  State<Sign_up_otp> createState() => _Sign_up_otpState();
}

class _Sign_up_otpState extends State<Sign_up_otp> {
  String setstateOtp = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void numberGet() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final dynamic username = prefs.getString('username');
      final dynamic email = prefs.getString('email');
      final dynamic password = prefs.getString('password');
      final dynamic otpStored = prefs.getString('otpverification');
      final dynamic phoneNumber= prefs.getString('mobilenumber');
      final dynamic otpExpire=prefs.getString("otpExpire");
      final currentTime=DateTime.now().millisecondsSinceEpoch;
      print("User enterd OTP is $setstateOtp & shared pre OTP is $otpStored");
      if (otpStored == setstateOtp) {
        if (currentTime>  int.parse(otpExpire) ){
            var snackBar = SnackBar(
          content: Text("otp time over"),
          backgroundColor: Color.fromARGB(255, 119, 0, 0),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
        }
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await firestore.collection('user')
            .add({"name": username, "email": email, "password": password,"mobilenumber":phoneNumber});

        prefs.setBool("isUserLogged", true);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print("please enter correct otp");
        var snackBar = SnackBar(
          content: Text("Incorrect OTP"),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      print(widget.phoneNumber);
      print(username);
    } catch (e) {
      print(e);
    }
  }

  String randum() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 4; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    if (rndnumber.startsWith("0")) {
      rndnumber = '1${rndnumber.substring(1)}';
    }
    print(rndnumber);
    return rndnumber;
  }

  void resendOtp() async {
    var resended = randum();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final dynamic username = prefs.getString('username');
    prefs.setString('otpverification', resended);
    print("Mobile number is${widget.phoneNumber}");
    sendSignupOtp(widget.phoneNumber, username, int.parse(resended));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 270),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 80,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (String? pin) {
                  if (pin?.length == 4) {
                    setState(() {
                      setstateOtp = pin!;
                    });
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpTimerButton(
                    onPressed: () {
                      print("pressed resend button");
                      resendOtp();
                    },
                    text: Text('Resend OTP'),
                    duration: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        numberGet();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      child: Text(
                        "Verify",
                        style: TextStyle(fontSize: 22),
                      )),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
