import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  String txt ;
  double ? fontSize=14;
  SmallText({super.key,required this.txt,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      txt, style: GoogleFonts.albertSans( textStyle: TextStyle(
      color: Color(0xff9A9A9A),
      fontSize: fontSize,
    ),
    ));
  }
}
