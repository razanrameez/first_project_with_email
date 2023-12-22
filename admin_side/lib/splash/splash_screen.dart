// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:admin_side/home/home.dart';
import 'package:admin_side/home/main_screen.dart';
import 'package:admin_side/login_page/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstScreen();
  }

  firstScreen() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences pref = await SharedPreferences.getInstance();
    var isAdminLogged = await pref.getBool("isAdminLogged");

    if (isAdminLogged != null && isAdminLogged) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sign_in()));
    }
    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Image.asset(
        "assets/images/loading-3.png",
        height: 100,
      ))),
    );
  }
}
