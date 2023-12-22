// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, empty_catches, non_constant_identifier_names, prefer_final_fields, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:admin_side/db/category_db.dart';
import 'package:admin_side/db/doctors_db.dart';
import 'package:admin_side/modals/doctor/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:admin_side/db/doctors_db.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {

  final GlobalKey<FormState>_Formkey=GlobalKey<FormState>();
TextEditingController _NameController=TextEditingController();
TextEditingController _fee=TextEditingController();
TextEditingController _Time_from_to=TextEditingController();
TextEditingController _qualification=TextEditingController();
TextEditingController _Experience=TextEditingController();
TextEditingController _dropdownController=TextEditingController();
TextEditingController _feeController=TextEditingController();
Map _dropDownValue= {
  'value': '',
  'displayName': "select category",
};

String _dropdowmQualification="Qualifications";
// String _dropDownfee="Doctor Fee";
String _dropdowYears="Doctor  experience";

var image;
var selectedImage;

FirebaseFirestore firestore=FirebaseFirestore.instance;
 Future <void> pickImage()async{
try {
  final imagePick =await ImagePicker().pickImage(source: ImageSource.gallery);
  if (imagePick==null) return;
  setState(() {
    image=imagePick.path;
    selectedImage=imagePick;
  });

}on PlatformException catch (e) {
  print('Failed to pick image: $e');
}
 }


Future <void> addDoctor()async{
    if (image == null) {
  var snackBar=SnackBar(content:Text("select an image !",style: TextStyle(color: Colors.white),),
  backgroundColor: Color.fromARGB(255, 48, 1, 1),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return;
  }

try {
var imageName=DateTime.now().microsecondsSinceEpoch.toString();
FirebaseStorage _storage=FirebaseStorage.instance;
 File imageFile = File(image);

  TaskSnapshot uploadTask = await _storage
          .ref().child("DoctorImage/$imageName").putFile(imageFile);
          String downloadUrl=await uploadTask.ref.getDownloadURL();
          print("Download url $downloadUrl");


          var id=DateTime.now().microsecondsSinceEpoch;

          print("Hive id is :" + id.toString());
          
          var fb_id=await firestore.collection("doctors").add({
            "image": downloadUrl,
            "name":_NameController.text,
            "id_hive":id.toString(),
            "category":_dropDownValue,
            "fee":_feeController.text,
            "Qualification":_dropdowmQualification,
            "experience":_dropdowYears,
          });

           var docs_id = fb_id.id;
           
           try{
      await addDoctorToHive(DoctorModel(
        name: _NameController.text,
        image_url: downloadUrl,
        id_hive: id.toString(),
        fb_id:docs_id,
        category: {}, 
        fee: _feeController.text,
        experience: _dropdowYears,
        ));

           }catch(e)
           {
           }

var snackBar=SnackBar(
  content: Text("category added succeesfully"),
  backgroundColor:Color.fromARGB(255, 2, 47, 18),);
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
} catch (e) {
  print ("error $e");
}
 }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      
      Column(
        children: [
          SizedBox(height: 43,),
         
          Form(
            key: _Formkey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    
                  SizedBox(height: 20,),
            IconButton(onPressed: (){
            Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),

           
                  Center(
                    
                    child: Stack(
                      children: [
  CircleAvatar(
    backgroundImage: image !=null ? FileImage(File(image)) as ImageProvider<Object> : AssetImage("assets/images/user.png"),
                      backgroundColor: const Color.fromARGB(255, 72, 112, 121),radius: 60,          
                    ),
                    Positioned(child: IconButton(onPressed: (){
                      pickImage();
                    }, icon: Icon(Icons.edit)
                    ),
                    bottom: 0,
                    right: 0,
                    )
                      ],
                    )
                  
                    
                  ),
                       SizedBox(height: 80,),
                  TextFormField(
                  controller:_NameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",          
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "enter this field";
                    }
                  },
                  ),
            

               SizedBox(height: 20,),

             TextFormField(
               controller: _feeController,
               keyboardType: TextInputType.name,
               decoration:InputDecoration(
                 border: OutlineInputBorder(),
               labelText: "fee"),
               validator: (value) {
                 if (value==null || value.isEmpty) {
                   return "enter this field";
                 }
               },
             ),
             

              //  `TextFormField(
              //   controller: _Time_from_to,
              //   decoration: InputDecoration( 
              //     border:OutlineInputBorder(),
              //     labelText:"starting time", 
              //     suffixIcon:IconButton(onPressed: _showTimePicker,
              //      icon: Icon(Icons.access_time_filled_sharp))
                 
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "enter this field";
              //     }
              //     return null;
              //   },
              //  ),`
              //  SizedBox(height: 20,),

              //  TextFormField(
              //   controller: _qualification,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: "qualification",
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "enter this field";
              //     }
              //   },
              //  ),
               
         

              //  TextFormField(
              //   controller: _Experience,
              //   decoration: InputDecoration(border: OutlineInputBorder(),
              //   labelText: "Experience"),
              //   keyboardType: TextInputType.name,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "enter this field";
              //     }
              //   },
              //  ),
               SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 170,
                          child: ValueListenableBuilder(
                            valueListenable: category_list,
                            builder : (context, value, child) {
                              return DropdownButton(
                            
                                hint: 
                                     Text(
                                        _dropDownValue['displayName'],
                                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black),
                                items: category_list.value.map(
                                  (val) {
                                    return DropdownMenuItem<Map<String,dynamic>>(
                                      value:{
                                        "value": val.id_hive,
                                        "displayName": val.name 
                                      },// val.id_hive,
                                      child: Text(val.name),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _dropDownValue = val!;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),

                     Container(
                          width: 170,
                          child: DropdownButton(
                          
                              hint:
                              //  _dropDownValue == null
                              //     ? Text('Dropdown')   :
                                   Text(
                                      _dropdowmQualification,
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.black),
                              items: ['MBBS', 'MD', 'Ed.D','PSY.D'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropdowmQualification= val!;
                                  },
                                );
                              },
                            ),
                        ),
                      ],
                    ),
               SizedBox(height: 30,),
                 Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   width: 170,
                        //   child: DropdownButton(
                          
                        //       hint:
                        //       //  _dropDownValue == null
                        //       //     ? Text('Dropdown')   :
                        //            Text(
                        //               _dropDownfee,
                        //               style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        //             ),
                        //       isExpanded: true,
                        //       iconSize: 30.0,
                        //       style: TextStyle(color: Colors.black),
                        //       items: ['200', '300', '400','500','600'].map(
                        //         (val) {
                        //           return DropdownMenuItem<String>(
                        //             value: val,
                        //             child: Text(val),
                        //           );
                        //         },
                        //       ).toList(),
                        //       onChanged: (val) {
                        //         setState(
                        //           () {
                        //             _dropDownfee = val!;
                        //           },
                        //         );
                        //       },
                        //     ),
                        // ),

                     Container(
                          width: 170,
                          child: DropdownButton(
                          
                              hint:
                              //  _dropDownValue == null
                              //     ? Text('Dropdown')   :
                                   Text(
                                      _dropdowYears,
                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: Colors.black),
                              items: ['Lessthan 1 Year', '1 Year', '2 year','3 year','4 year above'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropdowYears= val!;
                                  },
                                );
                              },
                            ),
                        ),
                      ],
                    ),
            
               
                ],
                
              ),
            ),    
          ),
          SizedBox(height: 30,),
       
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child:ElevatedButton(onPressed: (){
              if (_Formkey.currentState !=null) {
                if (_Formkey.currentState!.validate()) {
                  addDoctor();
                }
              }
            }, child: Text("Save",style: TextStyle(fontSize: 23),),
            style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),minimumSize: Size(380, 60),),
            
            ))
            
        ],
        
      )

    );
  }
}