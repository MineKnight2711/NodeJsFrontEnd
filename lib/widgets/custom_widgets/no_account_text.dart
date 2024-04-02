import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/controller/register_controller.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/transition.dart';

import '../../configs/constant.dart';
import '../../screens/sign_up/signup_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Bạn chưa có tài khoản?',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            Get.put(RegisterController());
            slideinTransition(context, const SignUpScreen());
          },
          child: const Text(
            'Đăng ký',
            style: TextStyle(fontSize: 16, color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
