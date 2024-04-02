import 'dart:convert';
import 'dart:io';

import 'package:quanlyquantrasua/model/account_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

AccountResponse? currentLogin;

class AccountController {
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
