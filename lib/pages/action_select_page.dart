import 'package:flutter/material.dart';
import 'package:uparking/config/common_functions.dart';
import 'package:uparking/constant/bar_text.dart';
import 'package:uparking/pages/print_page.dart';
import 'package:uparking/pages/scanning_page.dart';

import '../constant/app_colors.dart';


class ActionSelectPage extends StatefulWidget {
  const ActionSelectPage({super.key});

  @override
  State<ActionSelectPage> createState() => _ActionSelectPageState();
}

class _ActionSelectPageState extends State<ActionSelectPage> {
  bool isExit=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          //CommonFunction.transionRoute(context, AmcosMainPage(amcosId: amcosId.toString(),code:amcosCode.toString(),name:amcosName.toString()));

        }, icon:  Icon(Icons.arrow_back_ios_new_rounded, color:AppColor.whiteColor,size: 30.0,)),

        backgroundColor: AppColor.maincolor,
        title: BigText(txt:'PARKING PAGE',fontSize: 17,txtColor: AppColor.whiteColor,),
        actions: [
          //IconButton(onPressed: () {}, icon:  Icon(Icons.arrow_back, color:AppColor.whiteColor,size: 30.0,)),

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(onPressed:(){
              CommonFunction.transionRoute(context, ScanningPage(isExit: false,));

            }, icon:Icon(Icons.exit_to_app_outlined) ,label: BigText(txt: 'KUINGIA',txtColor: AppColor.whiteColor,),

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.bootProceedColor,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 100,),

            ElevatedButton.icon(onPressed:(){
              CommonFunction.transionRoute(context, ScanningPage(isExit: true,));

            }, icon:Icon(Icons.exit_to_app_outlined) ,label: BigText(txt: 'KUTOKA',txtColor: AppColor.whiteColor,),

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.bootDangerColor,
                foregroundColor: Colors.white,
              ),
            ),

            ElevatedButton.icon(onPressed:(){
              CommonFunction.transionRoute(context, PrintPage());

            }, icon:Icon(Icons.exit_to_app_outlined) ,label: BigText(txt: 'test',txtColor: AppColor.whiteColor,),

              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.bootDangerColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
