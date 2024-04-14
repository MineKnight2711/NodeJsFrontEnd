import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/model/response_model.dart';

import '../api/cart_api.dart';
import '../model/cart_model.dart';

class CartController extends GetxController {
  late CartApi _cartApi;
  late AccountController _accountController;
  RxList<CartModel> listCart = <CartModel>[].obs;
  RxList<CartModel> checkedItems = <CartModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _cartApi = CartApi();
    _accountController = Get.find<AccountController>();
    getByUserId();
  }

  Future<void> getByUserId() async {
    if (_accountController.userSession.value != null) {
      final response =
          await _cartApi.getByUserId(_accountController.userSession.value!.id);
      final listJson = response.data as List<dynamic>;
      listCart.value =
          listJson.map((item) => CartModel.fromJson(item)).toList();
    }
  }

  Future<ResponseModel> addToCart(
      String user, String drink, String size) async {
    return await _cartApi.addToCart(user: user, drink: drink, size: size);
  }

  Future<ResponseModel> deleteCartItem(String cartId) async {
    if (checkedItems.any((c) => c.id == cartId)) {
      checkedItems.removeWhere((element) => element.id == cartId);
    }
    return await _cartApi.deleteCartItem(cartId);
  }

  Future<ResponseModel> updateCartItem(String cartId, int quantity) async {
    return await _cartApi.updateCart(cartId, quantity);
  }
  // List<CartItem> cartItem = <CartItem>[].obs;
  // List<CartItem> checkedItem = <CartItem>[].obs;
  // bool isCheckAll = false;
  // final totalPrice = 0.0.obs;

  // void addToCart(CartItem item) {
  //   //Kiểm tra đối tượng Cartitem giống phương thức bên dưới
  //   final existingIndex = cartItem.indexWhere(
  //     (element) =>
  //         element.drink == item.drink &&
  //         element.size == item.size &&
  //         listEquals(element.toppings, item.toppings),
  //   );

  //   if (existingIndex != -1) {
  //     final existingItem = cartItem[existingIndex];
  //     final updatedItem =
  //         existingItem.copyWith(quantity: existingItem.quantity + 1);
  //     cartItem[existingIndex] = updatedItem;
  //     final indexCheckCart = checkedItem.indexOf(existingItem);
  //     if (indexCheckCart != -1) {
  //       checkedItem[indexCheckCart] = updatedItem;
  //       updateTotalPrice();
  //     }
  //   } else {
  //     cartItem.add(item.copyWith(quantity: 1));
  //   }
  // }

  // void checkAll() {
  //   if (isCheckAll == true) {
  //     checkedItem = List.from(cartItem);
  //     updateTotalPrice();
  //   } else {
  //     checkedItem.clear();
  //     updateTotalPrice();
  //   }
  // }

  // //Phương thức xoá giỏ hàng
  // void clearCart() {
  //   cartItem.clear();
  //   checkedItem.clear();
  //   totalPrice.value = 0;
  //   isCheckAll = false;
  // }
  // //Phương thức kiểm tra đối tượng item trong List checkedItem
  // //Nếu kết quả trả về -1 -> đối tượng tồn tại, ngược lại thì đối tượng không tồn tại

  // int queryChekedItemList(CartItem item) {
  //   return checkedItem.indexWhere(
  //     (element) =>
  //         element.drink == item.drink &&
  //         element.size == item.size &&
  //         listEquals(element.toppings, item.toppings),
  //   );
  // }

  // //Phương thức tick chọn từng item trong giỏ hàng
  // void checkPerItem(CartItem item) {
  //   if (queryChekedItemList(item) != -1) {
  //     checkedItem.remove(item);
  //     updateTotalPrice();
  //   } else {
  //     checkedItem.add(item);
  //     updateTotalPrice();
  //   }
  // }

  // double calculateItemTotal(CartItem item) {
  //   final dishPrice = item.drink.price ?? 0.0;
  //   final sizePrice = item.size.price ?? 0.0;
  //   final toppingPrice = item.toppings.fold(0.0,
  //       (previousValue, topping) => previousValue += (topping.price ?? 0.0));
  //   final itemPrice = (dishPrice + toppingPrice + sizePrice) * item.quantity;
  //   return itemPrice;
  // }

  // //Phương thức tính tổng sản phẩm đã chọn
  // void updateTotalPrice() {
  //   totalPrice.value = checkedItem.fold(0.0, (previousValue, item) {
  //     final dishPrice = item.drink.price;
  //     final sizePrice = item.size.price ?? 0.0;
  //     final toppingPrice = item.toppings.fold(0.0,
  //         (previousValue, topping) => previousValue += (topping.price ?? 0.0));
  //     final itemPrice = (dishPrice + toppingPrice + sizePrice) * item.quantity;
  //     return previousValue + itemPrice;
  //   });
  // }

  // void updateCartItem(CartItem oldItem, CartItem newItem) {
  //   final index = cartItem.indexOf(oldItem);
  //   if (index != -1) {
  //     cartItem[index] = newItem;
  //     final indexCheckCart = checkedItem.indexOf(oldItem);
  //     if (indexCheckCart != -1) {
  //       checkedItem[indexCheckCart] = newItem;
  //       updateTotalPrice();
  //     }
  //   }
  // }

  // void removeCheckedItemsFromCart() {
  //   for (CartItem item in checkedItem) {
  //     cartItem.removeWhere((cartItem) =>
  //         cartItem.drink == item.drink &&
  //         cartItem.size == item.size &&
  //         listEquals(cartItem.toppings, item.toppings));
  //   }
  //   // Clear the checkedItem list after removing items from cartItem
  //   checkedItem.clear();
  //   // Recalculate the total price
  //   updateTotalPrice();
  // }

  // void removeItem(CartItem item) {
  //   // Remove the item from cartItem
  //   cartItem.remove(item);
  //   // Check if the item is also in checkedItem
  //   final index = checkedItem.indexOf(item);
  //   if (index != -1) {
  //     // Remove the item from checkedItem
  //     checkedItem.removeAt(index);
  //     // Recalculate the total price
  //     updateTotalPrice();
  //   }
  // }
}
