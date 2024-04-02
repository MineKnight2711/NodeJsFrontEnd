import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/model/account_response.dart';

class ProfileController extends GetxController {
  final AccountResponse account;
  ProfileController(this.account);
  var isValidFullname = true.obs;
  var isValidPhonenumber = true.obs;
  var isValidAddress = true.obs;
  File? image;
  DateTime? date;
  String? selectedGender;
  TextEditingController fullnameController = TextEditingController();

  TextEditingController phonenumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  //Pương thức onClose được định nghĩa lại từ lớp cha là GexController,
  //Khi phương thức này được thực thi các lớp TextEditingController khai báo bên trên sẽ được loại bỏ để giảm thiểu tài nguyên sử dụng
  @override
  void onInit() {
    super.onInit();
    fullnameController.text = account.fullName.toString();
    phonenumberController.text = account.phoneNumber.toString();
    addressController.text = account.address.toString();
  }

  @override
  void onClose() {
    super.onClose();

    isValidFullname.value =
        isValidPhonenumber.value = isValidAddress.value = false;
    fullnameController.clear();
    phonenumberController.clear();
    addressController.clear();
    image = date = selectedGender = null;
  }

  String? validateFullname(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      isValidFullname.value = false;
      return 'Họ tên không được trống!';
    }
    isValidFullname.value = true;
    return null;
  }

  String? validatePhonenumber(String? phonenumber) {
    if (phonenumber == null || phonenumber.isEmpty) {
      isValidPhonenumber.value = false;
      return 'Số điện thoại không được trống!';
    }
    RegExp regex = RegExp(r'^(84|0)[35789]([0-9]{8})$');
    if (!regex.hasMatch(phonenumber)) {
      return 'Số điện thoại không đúng định dạng!';
    }
    isValidPhonenumber.value = true;
    return null;
  }

  String? validateAddress(String? address) {
    if (address == null || address.isEmpty) {
      isValidAddress.value = false;
      return 'Địa chỉ không được trống!';
    }
    isValidAddress.value = true;
    return null;
  }
}
