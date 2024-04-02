import 'dart:convert';

import 'package:get/get.dart';
import 'package:quanlyquantrasua/model/topping_model.dart';
import 'package:http/http.dart' as http;
import '../base_url_api.dart';

class ToppingApi extends GetxController {
  List<ToppingModel>? listTopping = <ToppingModel>[].obs();
  @override
  void onInit() {
    super.onInit();
    getAllTopping();
  }

  Future getAllTopping() async {
    try {
      final url =
          Uri.parse(ApiUrl.apiGetAllToppings); // Replace with your API endpoint

      final response = await http.get(url);
      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      listTopping =
          jsonData.map((data) => ToppingModel.fromJson(data)).toList();
      if (response.statusCode != 200) {
        throw Exception('Load toppings thất bại: ${response.body}');
      }
    } catch (e) {
      throw Exception('Không thể kết nối đến server: $e');
    }
  }
}
