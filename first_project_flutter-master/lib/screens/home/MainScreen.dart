import 'package:flutter/material.dart';

import 'home.dart';
import 'my_account.dart';
import 'my_bookings.dart';

class MainScreen extends StatefulWidget {
   MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   var selectedPage=0;

  var pageOption =[
    HomeScreen(),
    MyBooking(),
    MyAccount(),
  ];

  void onNavItemSelect (int items)
  {
setState(() {
  selectedPage=items;
});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: pageOption[selectedPage],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month),label: "My Booking"),
        BottomNavigationBarItem(icon: Icon(Icons.account_box),label: "Profile")
      ],
      onTap: onNavItemSelect,
      currentIndex: selectedPage,),
    );
  }
}