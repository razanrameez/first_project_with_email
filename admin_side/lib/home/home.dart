// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:admin_side/login_page/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hi Admin",style: TextStyle(fontWeight: FontWeight.bold),),
                IconButton(onPressed: ()
                // async
                {

                  // SharedPreferences pref= await SharedPreferences.getInstance();
                  // pref.clear();
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sign_in(),));
                  showDialog(context: context, builder: (context) => AlertDialog(
                    actions: [
                      
                      TextButton(onPressed: (){
                           Navigator.pop(context);               
                      }, child: Text("No",style: TextStyle(color: Colors.black),)),
                        TextButton(onPressed: ()async{
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sign_in(),));
                        SharedPreferences pref= await SharedPreferences.getInstance();
                  pref.clear();
                      }, child: Text("Yes",style: TextStyle(color: Colors.black),)),
                    ],
                    title: Text("Logout",style: TextStyle(color: Colors.red,fontWeight:FontWeight.bold)),
                    content: Text("are you sure"),
                  ),);
                }, icon:Icon(Icons.logout_outlined))
              ],
            
            ),
          ),
          SizedBox(height: 40,),
        Container(
          child: Center(
            
            child: Container(
              child:
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Text("user",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22),),
                   ),
                   Center(child: Text("1849",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 33),))
                 ],
               ),
              width: 380,
              height: 180,
              decoration: BoxDecoration(
                
                color: const Color.fromARGB(255, 2, 8, 13),
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                
              ),
              
            ),
            
          ),
        ),

SizedBox(height: 23,),

          Container(
          child: Center(
            
            child: Container(
              child:
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Text("Booking",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22),),
                   ),
                   Center(child: Text("149",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 33),))
                 ],
               ),
              width: 380,
              height: 180,
              decoration: BoxDecoration(
                
                color: const Color.fromARGB(255, 2, 8, 13),
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed 
              ),
              
            ),
            
          ),
        ),


SizedBox(height: 23,),

          Container(
          child: Center(
            
            child: Container(
              child:
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Text("Doctors",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22),),
                   ),
                   Center(child: Text("36",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 33),))
                 ],
               ),
              width: 380,
              height: 180,
              decoration: BoxDecoration(
                
                color: const Color.fromARGB(255, 2, 8, 13),
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                
              ),
              
            ),
            
          ),
        ),
        ],
      ),
    );
  }
}