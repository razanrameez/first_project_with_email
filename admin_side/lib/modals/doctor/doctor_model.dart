// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
part 'doctor_model.g.dart';

@HiveType(typeId: 1)
class DoctorModel{

  @HiveField(0)
  String id_hive;

  @HiveField(1)
  String fb_id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String image_url;

  @HiveField(4)
  Map category;

  @HiveField(5)
  String fee;

  @HiveField(6)
  String experience;


  

  DoctorModel({required this.name,required this.image_url, required this.id_hive, required this.fb_id, required this.category, required this.fee, required this.experience});
}

