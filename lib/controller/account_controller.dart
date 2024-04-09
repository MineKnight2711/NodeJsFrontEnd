import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:quanlyquantrasua/model/account_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountController extends GetxController {
  Rx<AccountResponse?> accountRespone = Rx<AccountResponse?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchCurrent();
  }

  Future fetchCurrent() async {
    accountRespone.value =
        await AccountController().getUserFromSharedPreferences();
  }

  Future<void> storedUserToSharedRefererces(
      AccountResponse accountResponse) async {
    final prefs = await SharedPreferences.getInstance();
    final accountJsonEncode = jsonEncode(accountResponse);
    await prefs.setString('currrent_account', accountJsonEncode);
  }

  Future<AccountResponse?> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('currrent_account') ?? '';
    if (jsonString.isNotEmpty) {
      return AccountResponse.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<AccountResponse?> getUserFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('currrent_account') ?? '';
    if (jsonString.isNotEmpty) {
      return AccountResponse.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('currrent_account');
  }
}
