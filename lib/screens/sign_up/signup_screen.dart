import 'package:flutter/material.dart';
import 'package:quanlyquantrasua/widgets/custom_widgets/custom_appbar.dart';
import 'components/Body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/signUp';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onPressed: () {
          // Get.delete<RegisterController>();
          Navigator.pop(context);
        },
        title: 'Đăng ký',
      ),
      body: const Body(),
    );
  }
}
