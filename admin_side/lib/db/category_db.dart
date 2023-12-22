// ignore_for_file: non_constant_identifier_names, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, prefer_is_empty, await_only_futures, unused_local_variable

import 'package:admin_side/modals/category/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
 
ValueNotifier<List<CategoryModel>> category_list = ValueNotifier([]);


void getAllCategoryList() async {

  

  bool _isNetworkConnectedOnCall = true;

  

  var category_box = await Hive.openBox<CategoryModel>("category");


      var fireStore = await FirebaseFirestore.instance;

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("category").get();

  List<CategoryModel> modalList = [];

  snapshot.docs.forEach((element) {
    var data = element.data() as Map<String, dynamic>;

    if (data.containsKey('name') && data.containsKey('image') && data.containsKey("id_hive")) {
       modalList.add(CategoryModel(name: data['name'],  image_url: data['image'], id_hive: data['id_hive'],fb_id: element.id));
    }
  });

    category_box.clear();
    if (modalList.length > 0) {
    category_box.addAll(modalList);
    category_list.value.addAll(modalList);
    category_list.notifyListeners();
  }
 
  // }else{
  //    category_list.value.addAll(category_box.values);
  // category_list.notifyListeners();

  // }

  
 
}

Future<CategoryModel> getCategoryNameFromID(String id) async
{
  var category_box = await Hive.openBox<CategoryModel>("category");
  return category_box.values.firstWhere((element) => element.id_hive==id);
}



Future<void> addNewCategory(category) async {
  var category_box = await Hive.openBox<CategoryModel>("category");
  category_box.add(category);
  category_list.value.add(category);
  category_list.notifyListeners();
}

Future<void> delete_all_category() async {
  var category_box = await Hive.openBox<CategoryModel>("category");
  category_box.clear();
  category_list.value.clear();
  category_list.notifyListeners();
}

Future<bool> delete_category(hive_id, fb_id) async {

  var category_box = await Hive.openBox<CategoryModel>("category");

  var key = category_box.keys.firstWhere( (key) => category_box.get(key)?.id_hive == hive_id ,orElse: () => null);

  category_list.value.removeWhere((element) => element.id_hive==hive_id);
  category_list.notifyListeners();


  if (key != null) {
    await category_box.delete(key);
  } else {
    print('Record with row_id $key not found.');
  }
 

  FirebaseFirestore _storage = await FirebaseFirestore.instance;
  _storage.collection("category").doc(fb_id).delete();
  return true;
}
