
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uparking/pages/action_select_page.dart';
import 'package:uparking/pages/scanning_page.dart';

import 'auth/auth__login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true,ignoreSsl: true);
  await dotenv.load(fileName: ".env");
  bool isLoggedIn=false;
  // HttpOverrides.global = MyHttpOverrides();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') == null) isLoggedIn=false;
    if (prefs.getBool('isLoggedIn') == true) isLoggedIn=true;

      runApp(isLoggedIn?const MyApp():const LoginMaterial());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Parking',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ActionSelectPage(),
    );
  }
}

class LoginMaterial extends StatelessWidget {
  const LoginMaterial({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UParking',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AppLoginPage(),
    );
  }
}

