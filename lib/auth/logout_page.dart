import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_colors.dart';
import 'auth__login_page.dart';


class AppLogout extends StatefulWidget {
  const AppLogout({super.key});

  @override
  State<AppLogout> createState() => _AppLogoutState();
}

class _AppLogoutState extends State<AppLogout> {

  void LogoutFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('access_token');
    print(prefs.getString('username'));

  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {

      // add your code here.

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AppLoginPage()),
      );
    });
    LogoutFunction();

    return LinearProgressIndicator(color: AppColor.mainblack,);
  }
}
