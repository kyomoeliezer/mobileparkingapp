import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

 class AppConfig{
  static  String base_url=dotenv.env['BASE_URL'].toString();

  static  String download_setting_url=base_url+"api/agro/get-agro-setting-data";
  static  String get_current_season_url=base_url+"api/agro/get-season-year";
  static  String get_your_assigned_amcos_url=base_url+"api/agro/get-your-assigned-amcos";
  static String go_parking=base_url+"api/parking/go-car-park";

  static  String loginUrl=base_url+"api/auth/login";

  static Future<String?> getAccessToken() async {
    SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();
    String? accessToken = _sharedPreferences.getString("access_token");
    return accessToken;
  }

  static Future<String?> getUserId() async {
    SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();
    String? userId = _sharedPreferences.getString("id");
    return userId;
  }

  static Future<String?> username() async {
    SharedPreferences _sharedPreferences =
    await SharedPreferences.getInstance();
    String? username = _sharedPreferences.getString("username");
    return username;
  }

  static errorToast(String message){
    Fluttertoast.showToast(
        msg: message,
        //gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        //backgroundColor: Colors.red,
        textColor: Colors.red,
        fontSize: 16.0
    );
  }

  static successToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        //gravity: ToastGravity.TOP,
        //backgroundColor: Colors.green,
        textColor: Colors.green
    );
  }

  static const decoration =  InputDecoration(

    labelStyle: TextStyle(
      fontSize: 18.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.grey),
    ),
  );
}