// ignore_for_file: prefer_const_constructors

import 'package:admin_side/Doctors/add_doctors.dart';
import 'package:admin_side/db/doctors_db.dart';
import 'package:flutter/material.dart';

class VieWDoctors extends StatefulWidget {
  const VieWDoctors({super.key});

  @override
  State<VieWDoctors> createState() => _VieWDoctorsState();
}

class _VieWDoctorsState extends State<VieWDoctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDoctor(),
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
                    valueListenable: doctor_list,
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
                            doctor_list.value.length,
                            (index) {
                              print(doctor_list.value[index].image_url);
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
                                      await delete_category(doctor_list.value[index].id_hive, doctor_list.value[index].fb_id);
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
                                      doctor_list.value[index].image_url !=null ? (
                                      Image.network(Uri.parse(doctor_list.value[index].image_url).toString(),height: 64,)
                                      ) :
                                      Image.asset(
                                        'assets/images/doctor_icon.png',
                                        height: 64,
                                      ),
                                      
                                      SizedBox(
                                        height: 10,
                                      ),
                                     
                                      Text(doctor_list.value[index].name),
                                      
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