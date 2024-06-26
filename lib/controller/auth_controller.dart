import 'package:get/get.dart';

import 'package:quanlyquantrasua/api/auth_api.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/model/user_model.dart';

import '../model/response_model.dart';

class AuthController extends GetxController {
  late AuthApi _auth;
  late AccountController _accountController;
  @override
  void onInit() {
    super.onInit();
    _auth = AuthApi();
    _accountController = Get.find<AccountController>();
  }

  Future<ResponseModel> login(String username, String password) async {
    try {
      final response = await _auth.login(username, password);
      return response;
    } catch (e) {
      return ResponseModel(success: false);
    }
  }

  Future<bool> getUserInfo(String token) async {
    final response = await _auth.getUserInfo(token);
    if (response.success) {
      print(response.data);
      _accountController.userSession.value = UserModel.fromJson(response.data);
      _accountController
          .storedUserToSharedRefererces(_accountController.userSession.value);
      return true;
    }
    return false;
  }

  Future<bool> register(String fullName, String password, String email,
      String address, String phone, String gender) async {
    final response =
        await _auth.register(fullName, password, email, address, phone, gender);
    return response.success;
  }

  Future<bool> forgotPassword(String email) async {
    final response = await _auth.forgotPassword(email);
    return response.success;
  }
}
