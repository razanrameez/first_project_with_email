// ignore_for_file: non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, prefer_is_empty, await_only_futures, unused_local_variable

import 'package:admin_side/db/category_db.dart';
import 'package:admin_side/modals/category/category_model.dart';
import 'package:admin_side/modals/doctor/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
 
ValueNotifier<List<DoctorModel>> doctor_list = ValueNotifier([]);


Future<ValueNotifier<List<DoctorModel>>> getAllDcotors() async {

   

  bool _isNetworkConnectedOnCall = true;


  var doctor_box = await Hive.openBox<DoctorModel>("doctors");


  var fireStore = await FirebaseFirestore.instance;

  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("doctors").get();  

  List<DoctorModel> modalList = [];

 for(var element in snapshot.docs) {
  
     var data =  element.data() as Map<String, dynamic>;
 
    if (data.containsKey('name') && data.containsKey('image') && data.containsKey("id_hive")) {
      var categoryData = await getCategoryNameFromID(data['category']['value']);
       
      Map categoryMap = {
        "value": categoryData.id_hive,
        "displayName" : categoryData.name
      };
       

        modalList.add(DoctorModel(name: data['name'],  image_url: data['image'], id_hive: data['id_hive'],fb_id: element.id,category: categoryMap,experience: data['experience'],fee: data['fee']));
  
    }
  };

 
    doctor_box.clear();
  if (modalList.length > 0) {
    doctor_box.addAll(modalList);
    doctor_list.value.addAll(modalList);
    doctor_list.notifyListeners();
  }

return doctor_list;
  // }else{
  //    category_list.value.addAll(category_box.values);
  // category_list.notifyListeners();

  // }

 
}



Future<void> addDoctorToHive(doctors) async {
  var doctor_box = await Hive.openBox<DoctorModel>("doctors");
  doctor_box.add(doctors);
  doctor_list.value.add(doctors);
  doctor_list.notifyListeners();
}

Future<void> delete_all_doctors() async {
  var doctor_box = await Hive.openBox<DoctorModel>("doctors");
  doctor_box.clear();
  doctor_list.value.clear();
  doctor_list.notifyListeners();
}

Future<bool> delete_category(hive_id, fb_id) async {

  var doctor_box = await Hive.openBox<DoctorModel>("doctors");

  var key = doctor_box.keys.firstWhere( (key) => doctor_box.get(key)?.id_hive == hive_id ,orElse: () => null);

  doctor_list.value.removeWhere((element) => element.id_hive==hive_id);
  doctor_list.notifyListeners();


  if (key != null) {
    await doctor_box.delete(key);
  } else {
    print('Record with row_id $key not found.');
  }


  FirebaseFirestore _storage = await FirebaseFirestore.instance;
  _storage.collection("doctors").doc(fb_id).delete();
  return true;
}
