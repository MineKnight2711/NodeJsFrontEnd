import 'dart:convert';
import 'package:quanlyquantrasua/api/base_url_api.dart';

import '../model/response_model.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<ResponseModel> register(String fullName, String password, String email,
      String address, String phone, String gender) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiRegister),
      body: jsonEncode({
        "fullName": fullName,
        "password": password,
        "email": email,
        "phoneNumber": phone,
        "address": address,
        "gender": gender,
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

  Future<ResponseModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiLogin),
      body: jsonEncode({
        'email': email,
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

  Future<ResponseModel> forgotPassword(String email) async {
    final Uri url = Uri.parse(ApiUrl.apiForgotPassword);
    final response = await http.post(url, body: {"email": email});

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Có lỗi xảy ra");
    }
  }
}
