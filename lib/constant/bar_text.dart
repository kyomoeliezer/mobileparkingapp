import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  String txt ;
  double ? fontSize;
  Color ? txtColor;
  bool ? overFlow;
  BigText({super.key,required this.txt,this.fontSize=15,this.overFlow,this.txtColor=const Color(0xff000000)});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt, style: GoogleFonts.albertSans( textStyle:TextStyle(
      color: txtColor,
      fontSize: fontSize,

    ),),
    );
  }
}


class BigTextOverFlow extends StatelessWidget {
  String txt ;
  double ? fontSize;
  Color ? txtColor;

  BigTextOverFlow({super.key,required this.txt,this.fontSize=20,this.txtColor=const Color(0xff000000)});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt, style: GoogleFonts.albertSans( textStyle:TextStyle(
      color: txtColor,
      fontSize: fontSize,

      overflow: TextOverflow.ellipsis,
    ),),
    );
  }
}

