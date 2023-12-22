import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstproject/modals/category_model/category_model.dart';
import 'package:firstproject/modals/doctor_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<CategoryModel>> doctor_list=ValueNotifier([

]);

void getAllDocter() async {
var fireStore=await FirebaseFirestore.instance;
var doctor_box=await Hive.openBox<DoctorModel>("doctors");
QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("doctors").get();

List<DoctorModel> modalList=[];

for (var element in snapshot.docs) {
  var data=element.data() as Map<String,dynamic>;
if (data !=null && data.containsKey('name') && data.containsKey('image')) {
  modalList.add(DoctorModel(name: data['name'], image_url:data['image'] ));
}
}
doctor_box.clear();
doctor_box.addAll(modalList);
doctor_list.notifyListeners();
print("Doctore count is " + modalList.length.toString());
}

