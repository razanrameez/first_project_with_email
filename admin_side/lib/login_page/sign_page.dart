// ignore_for_file: prefer_const_constructors, avoid_print, camel_case_types, prefer_final_fields, prefer_is_empty, unused_local_variable, use_build_context_synchronously, empty_statements


import 'package:admin_side/category/viewcategory.dart';
import 'package:admin_side/home/home.dart';
import 'package:admin_side/home/main_screen.dart';
import 'package:admin_side/login_page/verify_number.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void signingAction()async {
      SharedPreferences prefs= await SharedPreferences.getInstance();
  try {
    var data = await FirebaseFirestore.instance.collection("admin").where("email", isEqualTo:_email).get();
      var docs= data.docs;
    
      if (docs.length>=1) {
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      print("login Success");
        var snackBar = SnackBar(
          content: Text("Login Success",style: TextStyle(color: Colors.white),),
          backgroundColor: Color.fromARGB(255, 0, 38, 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
prefs.setBool("isAdminLogged", true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>MainScreen()));
      }else{
        var snackBar = SnackBar(
          content: Text("admin not founded",style: TextStyle(color: Colors.white),),
          backgroundColor: Color.fromARGB(255, 49, 0, 9),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    
    } catch (e) {     
      print(e);
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
                Text("Admin  Login",
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
