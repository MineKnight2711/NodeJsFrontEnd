import 'package:flutter/material.dart';
import 'package:quanlyquantrasua/screens/sign_in/components/sign_in_form.dart';

import '../../../widgets/custom_widgets/no_account_text.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const SignInForm(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                const SizedBox(
                  height: 20,
                ),
                const NoAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
