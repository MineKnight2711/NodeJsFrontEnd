import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isValidEmail = false.obs;
  var isValidOTP = false.obs;
  var isValidPassword = false.obs;
  var isValidReenter = false.obs;
  var isValidFullname = false.obs;
  var isValidPhonenumber = false.obs;
  var isValidAddress = false.obs;
  File? image;
  DateTime? date;
  String? selectedGender;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController reenterpassController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  //Pương thức onClose được định nghĩa lại từ lớp cha là GexController,
  //Khi phương thức này được thực thi các lớp TextEditingController khai báo bên trên sẽ được loại bỏ để giảm thiểu tài nguyên sử dụng
  @override
  void onClose() {
    super.onClose();
    isValidEmail.value = isValidPassword.value = isValidReenter.value =
        isValidFullname.value =
            isValidPhonenumber.value = isValidAddress.value = false;
    emailController.clear();
    otpController.clear();
    passController.clear();
    reenterpassController.clear();
    fullnameController.clear();
    phonenumberController.clear();
    addressController.clear();
    image = date = selectedGender = null;
  }

  //Kiểm tra email hợp lệ
  String? validateEmail(String? password) {
    if (password == null || password.isEmpty) {
      isValidEmail.value = false;
      return 'Email không được trống';
    }
    //Đây là Regex cho đa số trường hợp email, tuy nhiên vẫn có một số ngoại lệ như sau:
    //huynhphuocdat.siu@résumé.com đây là trường hợp email hợp lệ nhưng sẽ không match được regex này vì không hỗ trợ các ký tự nằm ngoài bảng mã ASCII
    //Thêm 1 trường hợp nữa là <datcute2711@yahoo.com> đây vẫn là 1 email hợp lệ nhưng cũng không match regex vì không hỗ trợ dấu < và >
    // RegExp emailRegex =
    //     RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    //Còn đây là regex cho riêng gmail
    RegExp gmailRegex = RegExp(
        r'[\w]*@*[a-z]*\.*[\w]{5,}(\.)*(com)*(@gmail\.com)',
        multiLine: true);
    if (!gmailRegex.hasMatch(password)) {
      isValidEmail.value = false;
      return 'Email không đúng định dạng';
    }

    isValidEmail.value = true;

    return null;
  }

  //Kiểm tra otp hợp lệ
  String? validateOTP(String? otp) {
    if (otp == null || otp.isEmpty) {
      isValidOTP.value = false;
      return 'OTP không được trống!';
    }
    final regex = RegExp(r'^[0-9]{6}$');
    if (!regex.hasMatch(otp)) {
      isValidOTP.value = false;
      return 'OTP phải là một chuỗi đúng 6 số.';
    }
    isValidOTP.value = true;
    return null;
  }

  //Kiểm tra mật khẩu hợp lệ
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      isValidPassword.value = false;
      return 'Mật khẩu không được trống';
    }

    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$');
    if (!regex.hasMatch(password)) {
      isValidPassword.value = false;
      return 'Mật khẩu phải chứa ít nhất:\n* 1 ký tự hoa,\n* 1 ký tự thường ,\n* 1 số,\n* 1 ký tự đặc biệt,\n* 8 ký tự';
    }

    isValidPassword.value = true;

    return null;
  }

  //Kiểm tra xác nhận mật khẩu hợp lệ
  String? validateReenterPassword(String? reenterpassword) {
    if (reenterpassword == null || reenterpassword.isEmpty) {
      isValidReenter.value = false;
      return 'Mật khẩu không được trống!';
    }
    if (reenterpassword != passController.text) {
      isValidReenter.value = false;
      return 'Mật khẩu không khớp!';
    }
    isValidReenter.value = true;
    return null;
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
