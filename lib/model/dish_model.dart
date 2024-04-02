// ignore_for_file: non_constant_identifier_names
import 'category_model.dart';


class DishModel {
  int? dishID;
  String? dishName;
  String? image;
  double? price;
  CategoryModel? categories;

  DishModel({
    this.dishID,
    this.dishName,
    this.image,
    this.price,
    this.categories,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {

    Map<String, dynamic> categoryJson = json['categories'];
    CategoryModel categoryModel = CategoryModel.fromJson(categoryJson);
    return DishModel(
      dishID: json['dishID'] as int,
      dishName: json['dishName'] as String,
      image: json['image'] as String,
      price: json['price'] as double,

      categories: categoryModel,
    );
  }

  Map<String, dynamic> toJson() => {
        'dishID': dishID,
        'dishName': dishName,
        'image': image,
        'price': price,
        'categories': categories!.toJson(),
      };
}
