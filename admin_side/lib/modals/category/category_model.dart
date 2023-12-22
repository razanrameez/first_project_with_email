import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel{

  @HiveField(0)
  String id_hive;

  @HiveField(1)
  String fb_id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String image_url;

  CategoryModel({required this.name,required this.image_url, required this.id_hive, required this.fb_id});

}



