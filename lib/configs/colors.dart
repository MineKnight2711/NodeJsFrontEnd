import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> indicators = [
    Color(0xffFED2C7),
    Color(0xffFED2C7),
    Color(0xffFEA58D),
    Color(0xffFE8160),
    Color(0xffFE724C),
  ];
  static const Color appTheme = Color(0xff06AB8D);
  // text
  static const Color white100 = Color(0xffffffff);
  static const Color white21 = Color(0x36ffffff);
  static const Color white10 = Color(0x1Affffff);

  static Color lightOrange = Colors.orange.withOpacity(0.5);
  static const Color orange100 = Color(0xffFE724C);
  static const Color orange80 = Color(0xffFE8160);
  static const Color orange50 = Color(0xffFEA58D);
  static const Color orange20 = Color(0xffFED2C7);

  static const Color dark100 = Color(0xff1A1D26);
  static const Color dark80 = Color(0xff2A2F3D);
  static const Color dark50 = Color(0xff4D5364);
  static const Color dark20 = Color(0xff6E7489);
  static const Color dark5 = Color(0xffE9EAEC);

  static const Color yellow100 = Color(0xffFFC529);
  static const Color yellow80 = Color(0xffFFD050);
  static const Color yellow50 = Color(0xffFFDF8B);
  static const Color yellow20 = Color(0xffFFEFC3);

  static const Color gray100 = Color(0xff9A9FAE);
  static const Color gray80 = Color(0xffA8ACB9);
  static const Color gray50 = Color(0xffC4C7D0);
  static const Color gray20 = Color(0xffEBEBEB);
  static const Color gray15 = Color.fromARGB(223, 235, 235, 235);
  static const Color gray5 = Color(0xffF5F5F5);
}

class TextColor {
  static Color get primary => const Color(0xffFC6011);
  static Color get primaryText => const Color(0xff4A4B4D);
  static Color get secondaryText => const Color(0xff7C7D7E);
  static Color get textfield => const Color(0xffF2F2F2);
  static Color get placeholder => const Color(0xffB6B7B7);
  static Color get white => const Color(0xffffffff);
}
