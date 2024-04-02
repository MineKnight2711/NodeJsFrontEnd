import 'package:flutter/foundation.dart';

import 'dish_model.dart';
import 'size_model.dart';
import 'topping_model.dart';

class CartItem {
  DishModel dish;
  int quantity;
  SizeModel size;
  List<ToppingModel> toppings;

  CartItem({
    required this.dish,
    required this.quantity,
    required this.size,
    required this.toppings,
  });
  //Tạo mã băm kết hợp cho một các đối tượng được chỉ định
  @override
  int get hashCode => Object.hash(dish, size, toppings);

  @override
  bool operator ==(Object other) {
    //method identical kiểm tra nếu 2 đối tượng giống nhau hay không
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.dish == dish &&
        other.quantity == quantity &&
        other.size == size &&
        //method listequals kiểm tra từng thuộc tính của 2 danh sách với nhau
        listEquals(other.toppings, toppings);
  }

  CartItem copyWith({
    DishModel? dish,
    int? quantity,
    SizeModel? size,
    List<ToppingModel>? toppings,
  }) {
    return CartItem(
      dish: dish ?? this.dish,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      toppings: toppings ?? this.toppings,
    );
  }
}
