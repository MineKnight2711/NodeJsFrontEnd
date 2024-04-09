import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/response_model.dart';
import '../base_url_api.dart';

class DrinkApi {
  Future<ResponseModel> getAllDish() async {
    final url = Uri.parse(ApiUrl.apiGetAllProduct);
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    throw Exception("Có lỗi xảy ra");
  }
}
