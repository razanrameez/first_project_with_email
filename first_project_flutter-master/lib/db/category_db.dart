import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstproject/modals/category_model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<CategoryModel>> category_list = ValueNotifier([
  
]);

void getAllCategoryList() async {
  var fireStore = await FirebaseFirestore.instance;
  var category_box = await Hive.openBox<CategoryModel>("category");

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("category").get();

  List<CategoryModel> modalList = [];

  snapshot.docs.forEach((element) {
    Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('name') && data.containsKey('image')) {
      modalList.add(CategoryModel(name: data['name'], image_url: data['image']));
    }
  });

  category_box.clear();
  category_box.addAll(modalList);
  category_list.value.addAll(modalList);
  category_list.notifyListeners();
}


