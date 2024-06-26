import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/account_controller.dart';
import 'package:quanlyquantrasua/controller/auth_controller.dart';
import 'package:quanlyquantrasua/controller/change_password_controller.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/default_button.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/messages_widget.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/showLoading.dart';
import '../../widgets/custom_widgets/custom_input_textformfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ChangePasswordController>();
  final _auth = Get.find<AuthController>();
  final accountController = Get.find<AccountController>();
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'Đổi mật khẩu',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputTextField(
                    controller: controller.emailController,
                    hintText: 'Nhập email...',
                    labelText: 'Email',
                    onChanged: controller.validateEmail,
                  ),
                  const SizedBox(height: 16.0),
                  DefaultButton(
                    press: () async {
                      showLoadingAnimation(context);
                      final result = await _auth
                          .forgotPassword(controller.emailController.text);

                      if (result) {
                        CustomToastMessage.showMessage("Đã gửi email reset");
                        Navigator.pop(context);
                      } else {
                        CustomErrorMessage.showMessage("Có lỗi xảy ra");
                      }
                    },
                    text: 'Gửi mail',
                    enabled: controller.isValidEmail.value,
                  ),
                  // const SizedBox(height: 16.0),
                  // CustomInputTextField(
                  //   controller: controller.otpController,
                  //   hintText: 'Nhập OTP...',
                  //   labelText: 'OTP',
                  //   onChanged: controller.validateOTP,
                  //   textInputType: TextInputType.number,
                  // ),
                  // const SizedBox(height: 16.0),
                  // CustomPasswordTextfield(
                  //   controller: controller.newpassController,
                  //   hintText: 'Nhập mật khẩu mới...',
                  //   labelText: 'Cập nhập mật khẩu',
                  //   onChanged: controller.validatePassword,
                  // ),
                  // const SizedBox(height: 16.0),
                  // CustomPasswordTextfield(
                  //   controller: controller.reenterpassController,
                  //   hintText: 'Xác nhận mật khẩu...',
                  //   labelText: 'Nhập lại mật khẩu',
                  //   onChanged: controller.validateReenterPassword,
                  // ),
                  // const SizedBox(height: 16.0),
                  // DefaultButton(
                  //   press: () async {
                  //     // String result = await accountController.changePassword(
                  //     //     controller.emailController.text,
                  //     //     controller.otpController.text,
                  //     //     controller.newpassController.text);
                  //     // CustomToastMessage.showMessage(result);
                  //   },
                  //   text: 'Đổi mật khẩu',
                  //   enabled: controller.isValidPassword.value &&
                  //       controller.isValidReenter.value,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
