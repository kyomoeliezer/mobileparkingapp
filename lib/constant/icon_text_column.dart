import 'package:flutter/material.dart';
import 'bar_text.dart';


class IconAndTextColum extends StatelessWidget {
  IconData icon;
  String txt;
  Color iconColor;
  Color txtColor;

  IconAndTextColum({super.key,required this.icon,required this.txt,this.iconColor=const Color(0xffffffff),this.txtColor=const Color(0xffffffff)});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,color: iconColor,),
        BigText(txt: txt,fontSize: 13,)
      ],
    );
  }
}
