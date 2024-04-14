import 'dart:convert';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  Rx<UserModel?> userSession = Rx<UserModel?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchCurrent();
  }

  Future fetchCurrent() async {
    userSession.value = await getUserFromSharedPreferences();
  }

  Future<void> storedUserToSharedRefererces(UserModel? user) async {
    final prefs = await SharedPreferences.getInstance();
    final accountJsonEncode = jsonEncode(user?.toJson());
    await prefs.setString('current_user', accountJsonEncode);
  }

  Future<UserModel?> getUserFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = prefs.getString('current_user');
    if (currentUser != null) {
      final userJson = jsonDecode(currentUser);
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('current_user');
    userSession.value = null;
  }
}
