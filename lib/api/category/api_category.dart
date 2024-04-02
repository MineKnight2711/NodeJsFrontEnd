import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quanlyquantrasua/api/base_url_api.dart';
import 'package:quanlyquantrasua/model/category_model.dart';
import 'package:quanlyquantrasua/model/dish_model.dart';

class CategoryApi extends GetxController {
  Rx<List<CategoryModel>?> listCategory = Rx<List<CategoryModel>?>([]);
  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

  Future getAllCategory() async {
    try {
      final url =
          Uri.parse(ApiUrl.apiGetAllCategory); // Replace with your API endpoint

      final response = await http.get(url);
      final jsonData =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      listCategory.value =
          jsonData.map((data) => CategoryModel.fromJson(data)).toList();
      if (response.statusCode != 200) {
        throw Exception('Load Account thất bại: ${response.body}');
      }
    } catch (e) {
      throw Exception('Không thể kết nối đến server: $e');
    }
  }

  Future<List<DishModel>?> loadDishByCategory(int categoryId) async {
    final response = await http
        .get(Uri.parse('${ApiUrl.apiGetDishesByCategory}/$categoryId'));
    if (response.statusCode == 200) {
      List<dynamic> dishesJson = json.decode(utf8.decode(response.bodyBytes));
      List<DishModel> dishes =
          dishesJson.map((dishJson) => DishModel.fromJson(dishJson)).toList();
      return dishes;
    } else {
      return null;
    }
  }
}
