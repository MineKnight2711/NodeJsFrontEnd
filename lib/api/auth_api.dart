import 'dart:convert';

import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/base_url_api.dart';

import '../model/response_model.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<ResponseModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiLogin),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Có lỗi xảy ra");
  }

  Future<ResponseModel> getUserInfo(String token) async {
    final Uri url = Uri.parse(ApiUrl.apiGetUserInfo);
    final http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error occurred while fetching user information");
    }
  }
}
