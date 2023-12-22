// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:firstproject/db/category_db.dart';
import 'package:firstproject/doctors/doctors.dart';
import 'package:firstproject/screens/home/my_account.dart';
import 'package:firstproject/screens/home/my_bookings.dart';
import 'package:firstproject/screens/login_page/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Row(   
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                children: [ CircleAvatar(
                  child: Image.asset('assets/images/userImage.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Razan Ramees",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),],
               ),

                IconButton(onPressed: ()async{
                  SharedPreferences pref= await SharedPreferences.getInstance();
                  pref.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Sign_in(),));
                }, icon:Icon(Icons.logout)),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/banner.jpg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    ValueListenableBuilder(
                      valueListenable: category_list,
                      builder: (context, value, child) {
                        return GridView.count(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            primary: false,
                            padding: const EdgeInsets.only(top: 50),
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            crossAxisCount: 3,
                            children: List.generate(
                              
                              category_list.value.length,
                              
                              (index) => GestureDetector(

                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Doctors()));
                                },
                                child: Card(
                                  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 0,
                                        ),
                                      category_list.value[index].image_url !=null ? (
                                        Image.network(Uri.parse(category_list.value[index].image_url).toString(),height: 64,)
                                      ) :
                                      Image.asset(
                                        'assets/images/doctor_icon.png',
                                        height: 64,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(category_list.value[index].name)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
