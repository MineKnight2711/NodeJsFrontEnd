import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../model/dish_model.dart';
import '../base_url_api.dart';

class DishApi extends GetxController {
  Rx<List<DishModel>?> listDish = Rx<List<DishModel>?>([]);
  @override
  void onInit() {
    super.onInit();
    getAllDish();
  }

  Future getAllDish() async {
    try {
      final url =
          Uri.parse(ApiUrl.apiGetAllProduct); // Replace with your API endpoint

      final response = await http.get(url);

      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      listDish.value =
          jsonData.map((data) => DishModel.fromJson(data)).toList();

      if (response.statusCode != 200) {
        throw Exception('Load món thất bại: ${response.body}');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      // throw Exception('Không thể kết nối đến server: $e');
    }
  }
}
