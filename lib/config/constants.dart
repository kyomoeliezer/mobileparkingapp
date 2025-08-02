import 'package:flutter/material.dart';

class Constant{

  static const closePreBuyMessage="Are you sure that you want to close the Pre Buying window.You will not be able to update data";
  static const closeBuyMessage="Are you sure that you want to close the Buying window.You will not be able to update data";
  static const flushMessage="Are you sure that you want to flush all data.You will lost all data permanently!";


  static const decoration =  InputDecoration(
    labelText: "Ticket ",
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

  static const formTextStyle=TextStyle(
    fontSize: 14.0,
    color: Colors.black87,
  );

  static const headerTextStyle=TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );


}