import 'package:get/get.dart';

import 'package:quanlyquantrasua/api/auth_api.dart';

class LoginController extends GetxController {
  late AuthApi _auth;
  @override
  void onInit() {
    super.onInit();
    _auth = AuthApi();
  }

  Future<bool> login(String username, String password) async {
    final response = await _auth.login(username, password);
    return response.success;
  }
}
