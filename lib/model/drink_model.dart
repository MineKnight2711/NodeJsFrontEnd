// ignore_for_file: non_constant_identifier_names
import 'package:quanlyquantrasua/model/topping_model.dart';

import 'category_model.dart';

class DrinkModel {
  String id;
  String drinkName;
  String description;
  String imageUrl;
  double price;
  CategoryModel category;
  List<ToppingModel> toppings;
  bool isDelete;
  // DateTime createdAt;
  // DateTime updatedAt;

  DrinkModel({
    required this.id,
    required this.drinkName,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.toppings,
    required this.isDelete,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: json['_id'],
      drinkName: json['drinkName'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      category: CategoryModel.fromJson(json['category']),
      toppings: (json['toppings'] as List<dynamic>)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList(),
      isDelete: json['isDelete'] == "true",
      // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
