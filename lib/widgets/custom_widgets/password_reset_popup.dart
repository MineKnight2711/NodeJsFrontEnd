import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanlyquantrasua/api/account/account_api.dart';

class ResetPasswordPopup extends StatefulWidget {
  const ResetPasswordPopup({super.key});

  @override
  ResetPasswordPopupState createState() => ResetPasswordPopupState();
}

class ResetPasswordPopupState extends State<ResetPasswordPopup> {
  TextEditingController emailController = TextEditingController();
  final accountController = Get.find<AccountApi>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter your email'),
      content: TextField(
        controller: emailController,
        decoration: const InputDecoration(hintText: 'Email'),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Send'),
          onPressed: () {
            accountController.sendOtpToEmail(emailController.text);
          },
        ),
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
