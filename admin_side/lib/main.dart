// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors

import 'package:admin_side/db/category_db.dart';
import 'package:admin_side/db/doctors_db.dart';
import 'package:admin_side/firebase_options.dart';
import 'package:admin_side/home/home.dart';
import 'package:admin_side/login_page/sign_page.dart';
import 'package:admin_side/modals/category/category_model.dart';
import 'package:admin_side/modals/doctor/doctor_model.dart';
import 'package:admin_side/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
  );
  

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if(!Hive.isAdapterRegistered(DoctorModelAdapter().typeId))
  {
    Hive.registerAdapter(DoctorModelAdapter());
  }
  // delete_all_category();
  // delete_all_doctors();
getAllCategoryList();
 getAllDcotors();
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          
          Splash_Screen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
