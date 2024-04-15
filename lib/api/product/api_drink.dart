import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/response_model.dart';
import '../base_url_api.dart';

class DrinkApi {
  Future<ResponseModel> getAllDish() async {
    final url = Uri.parse(ApiUrl.apiGetAllProduct);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> getByDrinkId(String drinkId) async {
    final url = Uri.parse("${ApiUrl.apiGetAllProduct}/$drinkId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> getByCategoryId(String id) async {
    final url = Uri.parse("${ApiUrl.apiGetAllProduct}/get-by-category/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> search(String q) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiGetAllProduct}/search?drinkName=$q"),
    );
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    throw Exception("Có lỗi xảy ra");
  }
}
