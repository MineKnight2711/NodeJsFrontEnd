import 'package:flutter/material.dart';

import '../../widgets/custom_widgets/custom_appbar.dart';
import 'components/sign_up_complete_body.dart';

class SignUpCompleteScreen extends StatelessWidget {
  const SignUpCompleteScreen(
      {super.key, required this.email, required this.password});
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        title: 'Đăng ký',
      ),
      body: SignUpCompleteBody(
        email: email,
        password: password,
      ),
    );
  }
}
