// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:firstproject/screens/home/MainScreen.dart';
import 'package:firstproject/screens/login_page/sign_page.dart';
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

  Future<void> firstScreen() async{
     // ignore: use_build_context_synchronously
         await Future.delayed(Duration(seconds: 2));

     SharedPreferences prefs= await SharedPreferences.getInstance();


    var isUserLogged = await prefs.getBool("isUserLogged");
    if(isUserLogged!=null && isUserLogged)
    {
         Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())); 
    }else{
    Navigator.push(context, MaterialPageRoute(builder: (context) => Sign_in()));
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:Center(child: Image.asset("assets/images/splash.png",height: 100,))),
    );
  }
}