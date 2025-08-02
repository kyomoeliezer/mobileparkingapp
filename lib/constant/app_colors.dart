import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppColor {
  static Color maincolor=Color(int.parse(dotenv.env['MAIN_COLOR'].toString()));
  static Color deepmaincolor=Color(int.parse(dotenv.env['DEEP_MAIN_COLOR'].toString()));
  static Color bottomNavGatorColor=Color(int.parse(dotenv.env['BOTTOM_NAVIGATOR_COLOR'].toString()));
  static Color txtAvataColor=Colors.green;
  static Color mainblack=Colors.black;
  static Color activeColor=Colors.blue;
  static Color warningColor=Color(0xffE4A11B);
  static Color successColor=Color(0xff86A335);
  static Color whiteColor=Colors.white;
  static Color defaultIconColor=Color(0xff9A9A9A);
  static Color errorBackgroundColor=Color(0xffFAA0A0);
  static Color faintColor=Color(0xff796c6c);
  static Color faintColor2=Color(0xff706969);
  static Color bootDangerColor=Color(0xffcc0000);
  static Color bootProceedColor=Color(0xff2a9fd6);

}