import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/account/account_api.dart';
import 'package:quanlyquantrasua/controller/register_controller.dart';
import 'package:quanlyquantrasua/screens/sign_up/sign_up_complete_screen.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_input_textformfield.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/transition.dart';
import '../../../widgets/custom_widgets/default_button.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});
  final controller = Get.find<AccountApi>();
  final registerController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Obx(
        () => Column(children: [
          CustomInputTextField(
              onChanged: registerController.validateEmail,
              controller: registerController.emailController,
              labelText: 'Email',
              hintText: 'Nhập Email'),
          const SizedBox(
            height: 20,
          ),
          CustomPasswordTextfield(
              onChanged: registerController.validatePassword,
              controller: registerController.passController,
              labelText: 'Mật khẩu',
              hintText: 'Nhập mật khẩu'),
          const SizedBox(
            height: 20,
          ),
          CustomPasswordTextfield(
              onChanged: registerController.validateReenterPassword,
              controller: registerController.reenterpassController,
              labelText: 'Xác nhận mật khẩu',
              hintText: 'Nhập lại mật khẩu'),
          const SizedBox(
            height: 40,
          ),
          DefaultButton(
            enabled: registerController.isValidEmail.value &&
                registerController.isValidPassword.value &&
                registerController.isValidReenter.value,
            text: 'Tiếp tục',
            press: () {
              slideinTransition(
                  context,
                  SignUpCompleteScreen(
                      email: registerController.emailController.text,
                      password: registerController.passController.text));
            },
          )
        ]),
      ),
    );
  }
}
