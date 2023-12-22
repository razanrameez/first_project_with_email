// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel{

  @HiveField(0)
  String name;

  @HiveField(1)
  String image_url;

  CategoryModel({required this.name,required this.image_url});

}
