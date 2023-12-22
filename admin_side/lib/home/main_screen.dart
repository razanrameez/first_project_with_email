import 'package:admin_side/Doctors/view_doctors.dart';
import 'package:admin_side/category/add_category.dart';
import 'package:admin_side/category/viewcategory.dart';
import 'package:admin_side/home/Doctors.dart';
import 'package:admin_side/home/Tokens.dart';
import 'package:admin_side/home/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var selectedPage=0;

  var pageOption =[
    HomeScreen(),
    ViewCategory(),
    // ManageDoctor(),
    VieWDoctors(),
    ManageToken(),
  ];

  void onNavItemSelect (int items)
  {
setState(() {
  selectedPage=items;
});
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: pageOption[selectedPage],
       bottomNavigationBar: BottomNavigationBar(
        onTap: onNavItemSelect,
        backgroundColor: Colors.black,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home",backgroundColor: Colors.grey),
        BottomNavigationBarItem(icon: Icon(Icons.category),label: "Category"),
        BottomNavigationBarItem(icon: Icon(Icons.health_and_safety),label: "Doctor"),
        BottomNavigationBarItem(icon: Icon(Icons.token),label: "Tokens"),
      ],
       )
    );
  }
}

