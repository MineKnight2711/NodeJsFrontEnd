import 'package:quanlyquantrasua/model/size_model.dart';
import 'package:quanlyquantrasua/model/topping_model.dart';

class ItemDrink {
  final String id;
  final String drinkName;
  final String imageUrl;
  final double price;

  ItemDrink({
    required this.id,
    required this.drinkName,
    required this.imageUrl,
    required this.price,
  });

  factory ItemDrink.fromJson(Map<String, dynamic> json) {
    return ItemDrink(
      id: json['_id'],
      drinkName: json['drinkName'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
    );
  }
}

class CartModel {
  final String id;
  final String user;
  final ItemDrink drink;
  final SizeModel size;
  final bool isHot;
  final List<ToppingModel> toppings;
  final int quantity;
  final bool isDeleted;

  CartModel({
    required this.id,
    required this.user,
    required this.drink,
    required this.size,
    required this.isHot,
    required this.toppings,
    required this.quantity,
    required this.isDeleted,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      user: json['user'],
      drink: ItemDrink.fromJson(json['drink']),
      size: SizeModel.fromJson(json['size']),
      isHot: json['is_hot'],
      toppings: (json['toppings'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList(),
      quantity: json['quantity'],
      isDeleted: json['isDelete'] == 'false',
    );
  }
}
