// ignore_for_file: prefer_const_constructors, avoid_print, camel_case_types, unused_local_variable, prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/screens/home/MainScreen.dart';
import 'package:firstproject/screens/home/home.dart';
import 'package:firstproject/screens/login_page/verify_number.dart';
import 'package:firstproject/screens/register/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  
final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey <FormState> _formKey=GlobalKey<FormState>();
///////
 TextEditingController _emailController=TextEditingController();
 TextEditingController _passwordController=TextEditingController();

 String _email="";
 String _password="";

  Future<void> signingAction()async {
     SharedPreferences prefs= await SharedPreferences.getInstance();
  try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      print("login Success");
              prefs.setBool("isUserLogged", true);

     Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>MainScreen()));
    } catch (e) {     
      print(e);
      var snackBar = SnackBar(
          content: Text("user not founded !",style: TextStyle(color: Colors.white),),
          backgroundColor: Color.fromARGB(255, 49, 0, 9),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [             
                Text("Sign in",
                     style: TextStyle(
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 33,
                    )),
                SizedBox(height: 200),
                TextFormField(
                  controller:_emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: " Email",
                    prefixIcon: Icon(Icons.email),
                  ),

                  
                  validator: (value) {

                    if (value == null || value.isEmpty) {
                      return "please enter your email";
                    }
                    // return null;
                     bool emailvalid=  RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(_email);
                     if (!emailvalid) {
                       return "enter valid email";
                     }

                    return null;
                  },
                 
                  onChanged: (value) {
                    setState(() {
                      _email=value;
                  });
                  },
                ),
          SizedBox(height: 40,),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(border: OutlineInputBorder(),
             labelText: "password",
            prefixIcon: Icon(Icons.lock),
           
          
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "enter your password";
              }else if(_passwordController.text.length<6){
return "password length should be greaterthan 5 character";
};

              return null;
            },
            onChanged: (value1) {
              setState(() {
                _password =value1;
              });
            },
          ),
          

                 Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(onPressed: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => Forgot_number()));
                  }, child: Text("forgottbutton",style: TextStyle(color: Colors.black),))),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("are you new here,"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sign_Up(),));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: 100,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState !=null) {
                            if (_formKey.currentState!.validate()) {
                                 signingAction();
                            }
                          }
                      
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text(
                          "Sign in ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
