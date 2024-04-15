import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/model/response_model.dart';
import '../api/cart_api.dart';
import '../model/cart_model.dart';
import '../model/drink_model.dart';
import '../model/topping_model.dart';

class CartController extends GetxController {
  late CartApi _cartApi;
  late AccountController _accountController;
  Rx<DrinkModel?> currentDrink = Rx<DrinkModel?>(null);
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

  Future<ResponseModel> addToCart(String user, String drink, String size,
      List<ToppingModel> toppings) async {
    List<String> toppingNames = toppings.map((topping) => topping.id).toList();
    return await _cartApi.addToCart(
        user: user, drink: drink, size: size, toppings: toppingNames);
  }

  Future<ResponseModel> deleteCartItem(String cartId) async {
    if (checkedItems.any((c) => c.id == cartId)) {
      checkedItems.removeWhere((element) => element.id == cartId);
    }
    return await _cartApi.deleteCartItem(cartId);
  }

  Future<ResponseModel> updateCartItem(
      String cartId, int quantity, String size, List<String> toppings) async {
    return await _cartApi.updateCart(cartId, quantity, toppings, size);
  }

  Future<ResponseModel> deleteCarts(List<String> items) async {
    return await _cartApi.deleteMultipleCartItems(items);
  }
}
