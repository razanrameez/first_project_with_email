// ignore_for_file: prefer_const_constructors, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, avoid_print, prefer_typing_uninitialized_variables, unused_field, no_leading_underscores_for_local_identifiers, sort_child_properties_last, unnecessary_null_comparison, unused_local_variable

import 'dart:io';

import 'package:admin_side/db/category_db.dart';
import 'package:admin_side/modals/category/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _Formkey = GlobalKey<FormState>();
  TextEditingController _categoryCoontroller = TextEditingController();
  var image;
  var selectedImage;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _categoriename = "";
  var circularloding=false;

  
  Future<void> addCategory() async {
    if (image == null) {
      var snackBar = SnackBar(
        content: Text(
          "select an image  !",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 49, 0, 9),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }


// CircularPErsentage(){
//   CircularPercentIndicator(radius: 100,lineWidth: 25,);
// }
    try {
      var imageName = DateTime.now().millisecondsSinceEpoch.toString();

      FirebaseStorage _storage = FirebaseStorage.instance;

      File imageFile = File(image);

      print("Pre Upload $imageFile");
      // Upload the image to Firebase Storage
      TaskSnapshot uploadTask = await _storage
          .ref()
          .child("category_image/$imageName")
          .putFile(imageFile);

      print("Post Upload");
      // Get the download URL for the uploaded image
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      print("Download URL: $downloadUrl");

      


      var id = DateTime.now().microsecondsSinceEpoch;

      // Add category details to Firestore
      var fb_id= await firestore.collection("category").add({
        "name": _categoryCoontroller.text,
        "image": downloadUrl,
        "id_hive": id.toString()
      });
        var docs_id = fb_id.id;

    
  
      await addNewCategory(CategoryModel(name: _categoryCoontroller.text, image_url: downloadUrl,id_hive: id.toString(),fb_id:docs_id ));

    
      print("Category added successfully!");
      var snackBar = SnackBar(
        content: Text("doctor added successfully"),
        backgroundColor: Color.fromARGB(255, 3, 48, 7),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print("Error adding category: $e");
    }

  }

  Future pickImage() async {
    try {
      final imagePick =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePick == null) return;
      setState(() {
        image = imagePick.path;
        selectedImage= imagePick;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 70,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)),
                Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Stack(children: [
                CircleAvatar(
                  backgroundImage: image != null
                      ? FileImage(File(image)) as ImageProvider<Object>
                      : AssetImage("assets/images/user.png"),
                  backgroundColor: Colors.white,
                  radius: 70,
                ),
                Positioned(
                  child: IconButton(
                    onPressed: () {
                      pickImage();
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  bottom: 0,
                  right: 0,
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: Form(
                  key: _Formkey,
                  child: TextFormField(
                    controller: _categoryCoontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Categorie Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter categorie name";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _categoriename = value;
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                  height: 60,
                  width: 370,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_Formkey != null) {
                          if (_Formkey.currentState!.validate()) {
                            addCategory();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(
                        "save",
                        style: TextStyle(fontSize: 26),
                      ))),
            )
          ],
        ),
        // Container(
        //   width: double.infinity,
        //   height: double.infinity,
        //   alignment: Alignment.center,
        //   color: Color.fromARGB(158, 0, 0, 0),
        //   child: CircularProgressIndicator()
        //   )
        SizedBox(height: 10,)
        ]
      )
      
    );
  }
}
