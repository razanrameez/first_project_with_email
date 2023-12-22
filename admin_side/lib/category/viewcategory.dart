// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison

import 'package:admin_side/category/add_category.dart';
import 'package:admin_side/db/category_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({super.key});

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

     

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategory(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),

          SizedBox(
            height: 30,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: category_list,
                    builder: (context, value, child) {
                      return (GridView.count(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          primary: false,
                          padding: const EdgeInsets.all(10),
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          crossAxisCount: 3,
                          
                          children: List.generate(
                            category_list.value.length,
                            (index) {
                              print(category_list.value[index].image_url);
                            return
                            GestureDetector(
                              onLongPress: ()
                              {
                                
                                print("Long pressed");
                                showDialog(context: context, builder: (ctx) {
                                  return AlertDialog(
                                  title: Text("Confirm"),
                                  content:  Text("Are you sure want to delete?"),
                                  actions: [
                                    
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: Text("Cancel")),
                                    TextButton(onPressed: () async{
                                      await delete_category(category_list.value[index].id_hive, category_list.value[index].fb_id);
                                      Navigator.pop(context);
                                      // delete_category(category_list.value[index].docs)
                                    }, child: Text("Confirm")),
                                  ],
                                );
                                });
                              },
                              child: Card(
                                
                                child: Container(
                                  padding: const EdgeInsets.all(8),
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
                                     
                                      Text(category_list.value[index].name),
                                      
                                    ],
                                  
                                  ),
                            
                                ),
                                
                              ),
                            );
                            }
                          )));
                    },
                  ),
                ],
                
              ),
            ),
          )
        ],
      ),
    );
  }
}
