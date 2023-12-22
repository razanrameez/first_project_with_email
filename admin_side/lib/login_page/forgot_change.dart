// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, depend_on_referenced_packages

import 'package:admin_side/login_page/sign_page.dart';
import 'package:flutter/material.dart';

class Forgott_change extends StatelessWidget {
  const Forgott_change({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              "Change Password",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              "entet 6 digit one time password code which is send to your registerd mobile number",
            ),
            SizedBox(
              height: 30,
            ),
            Text("enter the new password"),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Re - enter the new password"),
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 47,
              width: 90,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Sign_in())
                        );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    "submit",
                    style: TextStyle(fontSize: 17),
                  )),
            )
          ],
        ),
      ))),
    );
  }
}
