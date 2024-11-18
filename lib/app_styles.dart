import 'package:flutter/material.dart';

class AppStyles {

//button defaults

  static const Color defaultButtonColor = Color(0xFFff9d48);
  static const Color defaultBGColor = Color(0xFFf5f6f8);
  static const Color themeColor = Color(0xFFf7e7b4);
  static const Color textColor = Color(0xFF06768d);
  static const Color themeColorDarker = Color(0xFFffd02f);
  static const Color inputFillColor = Color(0xFFD6C0B3);
  static Color defaultButtonColorWithOpacity = const Color(0xFFff9d48)
      .withOpacity(0.3);
  static const Color defaultdisabledButtonColorWithOpacity = Colors.grey;

  static const TextStyle defaultTextStyle = TextStyle(
    color: Color(0xFF000000),
    fontSize: 36,
    fontFamily: "Roboto Bold",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle loginButtonStyle = TextStyle(
    color: Color(0xFFFFFFFF),
    fontSize: 17,
    fontFamily: "Roboto Bold",
    fontWeight: FontWeight.bold,
  );

}