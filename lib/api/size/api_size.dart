import 'dart:convert';

import 'package:quanlyquantrasua/model/response_model.dart';
import 'package:http/http.dart' as http;
import '../base_url_api.dart';

class SizeApi {
  Future<ResponseModel> getAllSize() async {
    final url = Uri.parse(ApiUrl.apiGetAllSize);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ResponseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
    }
    throw Exception("Có lỗi xảy ra");
  }
}
