import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future showLoadingAnimation(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white30,
        body: Center(
            child: Lottie.asset('assets/animations/ldanimation.json',
                width: 140, height: 140)),
      );
    },
  );
}
