import 'package:flutter/foundation.dart';
import 'package:quanlyquantrasua/model/user_model.dart';

import 'drink_model.dart';
import 'size_model.dart';
import 'topping_model.dart';

class CartModel {
  final String id;
  final String user;
  final DrinkModel drink;
  final SizeModel size;
  final bool isHot;
  final List<ToppingModel> toppings;
  final int quantity;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  CartModel({
    required this.id,
    required this.user,
    required this.drink,
    required this.size,
    required this.isHot,
    required this.toppings,
    required this.quantity,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      user: json['user']["_id"],
      drink: DrinkModel.fromJson(json['drink']),
      size: SizeModel.fromJson(json['size']),
      isHot: json['is_hot'],
      toppings: (json['toppings'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList(),
      quantity: json['quantity'],
      isDeleted: json['isDelete'] == 'false',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
