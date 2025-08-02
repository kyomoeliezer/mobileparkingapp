import 'package:uparking/auth/logout_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/common_functions.dart';
import '../constant/app_colors.dart';
import '../constant/bar_text.dart';


import '../config/common_functions.dart';

class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
 String username='';
 String fullName='';
 bool hasActionOnApp=false;
 bool can_view_dashboard=false;

  void getUsername() async {
    final datauser = await CommonFunction.getUsername();
    final fulName = await CommonFunction.getFullName();

    setState(() {
      username= datauser;
      fullName=fulName;
    });


  }
 void _setPreference() async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   //if (prefs.containsKey('isPreBuying')) isPreBuying=prefs.getBool('isPreBuying')!;
   if (prefs.containsKey('hasActionOnApp')) hasActionOnApp=prefs.getBool('hasActionOnApp')!;
   if (prefs.containsKey('can_view_dashboard')) can_view_dashboard=prefs.getBool('can_view_dashboard')!;


   setState(() {
     hasActionOnApp=hasActionOnApp;
   });
 }
 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    _setPreference();
  }

  @override
  Widget build(BuildContext context) {
    getUsername();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '${fullName}',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(

                    image: AssetImage('assets/images/icon/user.png',))),
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_outlined),
            title: Text(username.toUpperCase()),
            onTap: () => {},
          ),

 //connect










          ListTile(
            leading: Icon(Icons.square),
            title: Text('v02'),

          ),


          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Logout'),
            onTap: () => {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                     const  AppLogout(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end);
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    );

                    return SlideTransition(
                      position: tween.animate(curvedAnimation),
                      child: child,
                    );
                  }))

            },
          ),




        ],
      ),
    );
  }
}

class LeadingAvatarManu extends StatelessWidget {
  const LeadingAvatarManu({super.key});

  @override
  Widget build(BuildContext context) {
    return  BackButton(
      color: AppColor.whiteColor,
      onPressed: () {
        //CommonFunction.transionRoute(context, BlandedDispatchMainPage());

      },
    );
  }
}


