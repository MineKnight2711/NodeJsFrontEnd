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

  Future<ResponseModel> updateCart(
      String cartId, int quantity, List<String> toppings, String size) async {
    final body = {
      "quantity": quantity,
      "toppings": toppings,
      "size": size,
    };

    final response = await http.put(
      Uri.parse("${ApiUrl.apiCart}/update-cart-item/$cartId"),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
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

  Future<ResponseModel> deleteMultipleCartItems(List<String> ids) async {
    try {
      const url = '${ApiUrl.apiCart}/delete-multiple-item';

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'ids': ids}),
      );

      // Check if the request was successful (status code 200-299)
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      }
      throw Exception("Có lỗi xảy ra");
    } catch (error) {
      rethrow;
    }
  }
}
