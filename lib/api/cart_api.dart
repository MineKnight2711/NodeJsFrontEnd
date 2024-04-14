import 'dart:convert';

import 'package:quanlyquantrasua/api/base_url_api.dart';
import 'package:quanlyquantrasua/model/response_model.dart';
import 'package:http/http.dart' as http;

class CartApi {
  Future<ResponseModel> addToCart({
    required String user,
    required String drink,
    required String size,
    bool? isHot,
    List<String>? toppings,
    int quantity = 1,
  }) async {
    final url = Uri.parse("${ApiUrl.apiCart}/add-to-cart");

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'user': user,
      'drink': drink,
      'size': size,
      'is_hot': isHot ?? false,
      'toppings': toppings ?? [],
      'quantity': quantity,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ResponseModel.fromJson(data);
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> deleteCartItem(String cartId) async {
    final response = await http
        .delete(Uri.parse("${ApiUrl.apiCart}/delete-cart-item/$cartId"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ResponseModel.fromJson(data);
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> updateCart(String cartId, int quantity) async {
    final response = await http.put(
      Uri.parse("${ApiUrl.apiCart}/update-cart-item/$cartId"),
      body: {"quantity": quantity},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ResponseModel.fromJson(data);
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> getByUserId(String user) async {
    final response = await http.get(Uri.parse("${ApiUrl.apiCart}/$user"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ResponseModel.fromJson(data);
    }
    throw Exception("Có lỗi xảy ra");
  }
}
