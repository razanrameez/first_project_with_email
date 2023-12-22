// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
part 'doctor_model.g.dart';

@HiveType(typeId: 1)
class DoctorModel {

  @HiveField(0)
  String name;

  @HiveField(1)
  String image_url;

  DoctorModel({required this.name, required this.image_url});
}