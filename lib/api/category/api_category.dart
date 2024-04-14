import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quanlyquantrasua/api/base_url_api.dart';
import 'package:quanlyquantrasua/model/drink_model.dart';
import 'package:quanlyquantrasua/model/response_model.dart';

class CategoryApi {
  Future<ResponseModel> getAllCategory() async {
    final url =
        Uri.parse(ApiUrl.apiGetAllCategory); // Replace with your API endpoint

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    return ResponseModel(success: false, data: null);
  }
}
