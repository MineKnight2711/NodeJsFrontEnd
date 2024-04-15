import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanlyquantrasua/api/base_url_api.dart';
import 'package:quanlyquantrasua/model/response_model.dart';

class OrderItem {
  final String cartItem;
  final int quantity;

  OrderItem({
    required this.cartItem,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      cartItem: json['cart_item'],
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cart_item': cartItem,
      'quantity': quantity,
    };
  }
}

class OrderController {
  static Future<ResponseModel> saveOrder({
    required String user,
    required List<OrderItem> orderItems,
  }) async {
    final body = jsonEncode({
      'user': user,
      'order_date': DateTime.now().toIso8601String(),
      'order_items': orderItems.map((item) => item.toJson()).toList(),
    });

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.apiOrder),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      }
      throw Exception('Failed to save order: ${response.statusCode}');
    } catch (e) {
      rethrow;
    }
  }
}
