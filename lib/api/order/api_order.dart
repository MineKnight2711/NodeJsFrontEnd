// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/order_model.dart';
import '../base_url_api.dart';

class FetchApiOrderService {
  //singleTon Partern
  static final FetchApiOrderService instance = FetchApiOrderService._internal();
  factory FetchApiOrderService() {
    return instance;
  }
  FetchApiOrderService._internal();

  static Future<OrderResponse?> createOrder(
      int id, List<DishOrder> list) async {
    final body = <String, dynamic>{
      "accountId": id,
      "orderDate": '',
      "dishes": List.generate(list.length, (index) {
        return {
          "dishId": list[index].dishId,
          "quantity": list[index].quantity,
          "sizeId": list[index].sizeId,
          "listTopping": List.generate(list[index].listTopping!.length, (i) {
            return {
              "toppingId": list[index].listTopping![i].toppingId,
            };
          }),
        };
      })
    };
    var url = Uri.parse(ApiUrl.apiCreateOrder);
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      // ignore: avoid_print
      print(response.body);
      // var order = OrderResponse.fromJson(jsonDecode(response.body));
      // return order;
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }
}

class DishOrder {
  int? dishId;
  int? quantity;
  int? sizeId;
  List<ToppingOrder>? listTopping;

  DishOrder({
    this.dishId,
    this.quantity,
    this.sizeId,
    this.listTopping,
  });

  DishOrder.fromJson(Map<String, dynamic> json) {
    dishId = json["productId"];
    quantity = json["quantity"];

    listTopping = json["listTopping"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dishId"] = dishId;
    data["quantity"] = quantity;
    data["listTopping"] = listTopping;
    return data;
  }
}

class ToppingOrder {
  int? toppingId;

  ToppingOrder({
    this.toppingId,
  });

  ToppingOrder.fromJson(Map<String, dynamic> json) {
    toppingId = json["toppingId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["toppingId"] = toppingId;
    return data;
  }
}
