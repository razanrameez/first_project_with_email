// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, prefer_final_fields, camel_case_types, non_constant_identifier_names, unused_field, must_call_super, prefer_is_empty, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstproject/screens/register/verify_mobile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _email = "";
  String _password = "";
  String _fullname = "";
  String _ConfirmPassword = "";
  bool _passwordVisible = true;
  bool _conformpasswordvisible = true;
  bool isEmailAlreadyExitst= false;

  void _handleSignUp() async {
    try {
      if(await isEmailAlreadyExitstChecker(_email))
      {
        setState(() {
          isEmailAlreadyExitst=true;

        });
        return;
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('username', _fullname);
      await prefs.setString('email', _email);
      await prefs.setString('password', _password);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SignUp_Mobile_Number()));
    } catch (e) {
      print("Error During Registeration: $e");
    }
  }

  Future<bool> isEmailAlreadyExitstChecker(email)async{
     var allreadyRegistred= await FirebaseFirestore.instance.collection("user").where("email",isEqualTo: email).get();
if(allreadyRegistred.docs.length>=1){
 return true;
}
return false;
  }

  @override
  void initState() {
    _passwordVisible = false;
    _conformpasswordvisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))),
              Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 90,
              ),
////////////
              TextFormField(
                controller: _fullNameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Full Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your name";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _fullname = value;
                  });
                },
              ),
              
//////////////

              SizedBox(
                height: 30,
              ),
              TextFormField(

                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    errorText: isEmailAlreadyExitst ? "Email address already exist" : null,
                    border: OutlineInputBorder(), labelText: "Email"),
                validator: (value)  {
                  if (value == null || value.isEmpty) {
                    return "please enter your email";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),

////////////

              SizedBox(
                height: 30,
              ),

              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter password";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
///////////////
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_conformpasswordvisible,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _conformpasswordvisible = !_conformpasswordvisible;
                        });
                      },
                      icon: Icon(
                        _conformpasswordvisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      )),
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                ),
                validator: (thisValue) {
                  if (thisValue == null || thisValue.isEmpty) {
                    return "enter confirm password";
                  }
                  if (_password != thisValue) {
                    return 'password do not match';
                  }
                  return null;
                },
                onChanged: (value1) {
                  setState(() {
                    _ConfirmPassword = value1;
                  });
                },
              ),

              SizedBox(
                height: 30,
              ),

              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        _handleSignUp();
                      }
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text("Sign Up"))
            ],
          ),
        ),
      )),
    );
  }
}
