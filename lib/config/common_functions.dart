import 'dart:io';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../constant/app_colors.dart';
import 'app_config.dart';
import 'storage_common_function.dart';
import '../constant/bar_text.dart';
import '../db/sql_db_helper.dart';


class CommonFunction{
  ///DROPDOWN MENU LIST ON REQUIRE
  static   List<DropdownMenuItem<String>> getDropDownMenuItem(List<Map<String, dynamic>> querysetdata ){
    print(querysetdata);
    return querysetdata.map(
            (e) => DropdownMenuItem( value: (e['name']).toString(),child:Text( e['name']))//DropDownValueModelList.fromJson(e)
    ).toList();
  }

  static   List<DropdownMenuItem<String>> getDropDownMenuItemDynamic(List<dynamic> querysetdata ){

    List<DropdownMenuItem<String>>  data= querysetdata.map(
            (e) => DropdownMenuItem( value: (e['name']).toString(),child:Text( e['name']))//DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select ')));
    return data;
  }
  static   List<DropdownMenuItem<String>> getDropDownMenuItemDynamicInHouse(List<dynamic> querysetdata ){

    List<DropdownMenuItem<String>>  data= querysetdata.map(
            (e) => DropdownMenuItem( value: (e['grade']).toString(),child:Text( e['grade']))//DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select ')));
    return data;
  }
  static   List<DropdownMenuItem<String>> getDropDownMenuItemDynamicSections(List<dynamic> querysetdata ){

    List<DropdownMenuItem<String>>  data= querysetdata.map(
            (e) => DropdownMenuItem( value: (e['id']).toString(),child:Text( e['section_name']))//DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select ')));
    return data;
  }
  static   List<DropdownMenuItem<String>> getDropDownMenuItemDynamicBuyers(List<dynamic> querysetdata ){

    List<DropdownMenuItem<String>>  data= querysetdata.map(
            (e) => DropdownMenuItem( value: (e['buyer_code']).toString(),child:Text( e['buyer_code']))//DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select ')));
    return data;
  }
  static   List<DropdownMenuItem<String>> getDropDownMenuItemDynamicVerifiers(List<dynamic> querysetdata ){

    List<DropdownMenuItem<String>>  data= querysetdata.map(
            (e) => DropdownMenuItem( value: (e['code']).toString(),child:Text( e['code']))//DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select ')));
    return data;
  }
  static List<DropdownMenuItem<String>> getDropDownMenuItemAndValueWarehouse(List<dynamic> querysetdata ) {
    print(querysetdata);
    List<DropdownMenuItem<String>>  data=  querysetdata.map(
            (e) =>
            DropdownMenuItem(value: (e['warehouse_name']).toString(),
                child: Text(e['warehouse_name'])) //DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select warehouse')));
    return data;
  }
  static   List<DropdownMenuItem<String>> getDropDownMenuItemAndValue(List<Map<String, dynamic>> querysetdata ){
    print(querysetdata);
    return querysetdata.map(
            (e) => DropdownMenuItem( value: (e['name']).toString(),child:Text( e['name']))//DropDownValueModelList.fromJson(e)
    ).toSet().toList();
  }

  ///DROPDOWN LIST WITH EMPTY
  static List<DropdownMenuItem<String>> getDropDownMenuItemWithOneEmpty(List<Map<String, dynamic>> querysetdata ){
    List<DropdownMenuItem<String>>  data= querysetdata.map(
            (e) => DropdownMenuItem( value: (e['name']).toString(),child:Text( e['name']))//DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( 'Select ')));

    return data;
  }

  static List<DropdownMenuItem<String>>dropdownItems(){
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text(""),value: ""),
      DropdownMenuItem(child: Text("Cancelled"),value: "c"),
      DropdownMenuItem(child: Text("Rejected"),value: "r"),
      DropdownMenuItem(child: Text("Withdrawn"),value: "w"),
    ];
    return menuItems;
  }

 static  Future<String>  getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


      return prefs.getString('username').toString();
  }
  static  Future<String>  getFullName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    return prefs.getString('full_name').toString();
  }

  static String null_checker(dynamic data) {
    if ((data == 'null') | (data == null))
      return '';

    else
      return data.toString();
  }
  static Widget space(double value) {
    return Column(
        children:[
          Divider(height: 2,),
          SizedBox(
            height: value,
          ),
        ]);

  }

  static Color widgetColorWithCounter(int data){
    return   (data >= 1)? AppColor.maincolor : AppColor.defaultIconColor;
  }
  static Color widgetColor(List data){
    return   (data.length >= 1)? AppColor.maincolor : AppColor.defaultIconColor;
  }

  static Future<http.Response> getHttpRequest(urlstring) async{
    String? accessToken = await AppConfig.getAccessToken();
    return await http.get(Uri.parse(urlstring), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $accessToken",
    });

  }
  static void customSnack(BuildContext context,String txt,int data_type,[int  duration=5]){

    if(data_type ==1) AppConfig.successToast(txt);
    else AppConfig.errorToast(txt);
    /*ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: BigText(txt:"${txt}",txtColor:data_type==1? Colors.green:Colors.red,),
    duration: Duration(seconds:duration !=null?duration:5),

  ));*/
  }

  static  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }



  static Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static void transionRoute(BuildContext context,page){
    Navigator.push(context, scaleIn(page));

  }



}
