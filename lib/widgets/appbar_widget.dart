
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uparking/pages/scanning_page.dart';
import '../constant/app_colors.dart';
import '../constant/bar_text.dart';
import '../widgets/nav_drawer.dart';

PreferredSizeWidget commonAppBar({String title='',String backwhere=''}) {
  return AppBar(

    backgroundColor: AppColor.maincolor,
    title: Center(child: BigText(txt:title,txtColor: AppColor.whiteColor,fontSize: 20,)),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search, size: 30.0,)),

    ],
  );
}


class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
   final AppBar appBar;
   String title='';

   String backWhere='';
   bool hasActionOnApp=true;

  /// you can add more fields that meet your needs

  BaseAppBar({required this.title,required this.backWhere,required this.appBar,this.hasActionOnApp=true});


  @override
  Widget build(BuildContext context)  {

    return AppBar(
      leading: InkWell(
        onTap: (){
          if (hasActionOnApp) {
            backWhere == 'more_menu' ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScanningPage()),):Navigator.push(
              context, MaterialPageRoute(builder: (context) => ScanningPage()),);
          }

            switch(backWhere){
            case 'prebuying': Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ScanningPage()),
            );



          }

        },
        child: Icon(Icons.arrow_back_ios_new,color:AppColor.whiteColor),
      ),
      backgroundColor: AppColor.maincolor,
      title: BigText(txt:title,fontSize: 17,txtColor: AppColor.whiteColor,),
      actions: [
        IconButton(onPressed: () {}, icon:  Icon(Icons.search, color:AppColor.whiteColor,size: 30.0,)),

      ],


    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

class MainBaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  String title='';
  String backWhere='';
  bool hasActionOnApp=true;
  Map<String,dynamic> ? accessData;

  /// you can add more fields that meet your needs

  MainBaseAppBar({required this.title,required this.backWhere,required this.appBar,this.hasActionOnApp=true,this.accessData});


  @override
  Widget build(BuildContext context)  {

    return AppBar(
      leading:IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: Icon(Icons.account_circle_outlined,size: 40,color: AppColor.whiteColor,)),
      backgroundColor: AppColor.maincolor,
      title: BigText(txt:title,fontSize: 17,txtColor: AppColor.whiteColor,),
      actions: [
        IconButton(onPressed: () {}, icon:  Icon(Icons.more_vert_outlined, color:AppColor.whiteColor,size: 30.0,)),

      ],


    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}


Widget _dropDownWidget(){
  return PopupMenuButton(

    itemBuilder: (context) => [
      PopupMenuItem(
        child: StatefulBuilder(
          builder: (_context, _setState) =>

              Container(

                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.4,
                child: Column(
                  children: [


                    Row(
                      children: [

                        Expanded(child: BigTextOverFlow(txt: 'Sync Error',fontSize: 16,)),

                      ],
                    ),
                  ],
                ),
              ),



        ),
      ),


    ],
  );
}