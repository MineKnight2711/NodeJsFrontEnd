import 'package:flutter/material.dart';

import 'package:quanlyquantrasua/screens/sign_up/components/sign_up_complete_form.dart';

class SignUpCompleteBody extends StatelessWidget {
  const SignUpCompleteBody(
      {super.key, required this.email, required this.password});
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const Text(
                'Hoàn tất đăng ký',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black),
              ),
              const Text(
                'Cho chúng tôi biết về bạn',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              SignUpCompleteForm(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
