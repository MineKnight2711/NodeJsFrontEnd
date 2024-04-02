// ignore_for_file: unused_element

import 'package:get/get.dart';

import 'package:quanlyquantrasua/model/account_model.dart';

class UserController {
  var listAccount = <Accounts>[].obs;

  get _list => listAccount;

  set _listAccount(value) => listAccount = value;
}
