

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uparking/pages/scanning_page.dart';
import '../config/app_config.dart';
import '../config/common_functions.dart';
import '../constant/app_colors.dart';
import '../constant/bar_text.dart';
import '../constant/small_text.dart';
import 'package:flutter/services.dart';

import '../widgets/loading_with_words.dart';


class AppLoginPage extends StatefulWidget {
  const AppLoginPage({super.key});

  @override
  State<AppLoginPage> createState() => _AppLoginPageState();

}

class _AppLoginPageState extends State<AppLoginPage> {
  bool isProcessing=false;
  bool _passwordVisible=false;
  bool _obscureText=true;
  String ?role;
  String errorText='';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _username= new TextEditingController();
  TextEditingController _password= new TextEditingController();
  bool hasActionOnApp=false;
  bool can_view_dashboard=false;



  void loginNow(String username,String password) async{
    if((username !='') |(username !=null)) {
      try {
        setState(() {
          isProcessing = true;
        });
        http.Response response = await http.post(
          Uri.parse(AppConfig.loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }),
        );
        print('username:-' + username);
        print('password-:' + password);
        if (response.statusCode == 200) {
          var dataob = jsonDecode(response.body);
          var userData = jsonDecode(response.body);
          print('LOjsonDecode(response.body');
          print(jsonDecode(response.body));
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("id", userData['user_details']['id'].toString());
          preferences.setString("access_token", userData['access_token']);
          preferences.setString('role', userData['role']);
          String role=userData['role'];
          //bool can_work_offline=userData['can_work_offline'];

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ScanningPage()),
          );

          preferences.setString(
              "username", userData['user_details']['username']);
          preferences.setString(
              "full_name", userData['user_details']['full_name']);
          print('HAPA2');
          preferences.setBool("isLoggedIn", true);
          //await CommonFunction.standardWeights();
          if(userData['user_details']['username'] !=null){

          }
          else setState((){
            errorText = 'Error Login problem ';
            _password.text = '';
            isProcessing = false;
          });

        }
        else {
          var dataob = jsonDecode(response.body);
          print('Imefeli bwana');
          print(response.statusCode);
          print(jsonDecode(response.body));
          setState(() {
            errorText = dataob['detail'];
            _password.text = '';
            isProcessing = false;
          });
        }
      }
      catch (e) {
        CommonFunction.customSnack(context, e.toString(), 0);
        setState(() {
          isProcessing = false;
        });
      }
    }
  }





  @override
  void initState() {
    _passwordVisible = false;
    _obscureText=true;
  }


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body:isProcessing?LoadingIndicatorOnly(): Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  height: height*0.35,
                  child: Image.asset('assets/images/icon/user.png',fit: BoxFit.contain,),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BigText(txt: 'Parking Login',fontSize: 24,txtColor: AppColor.mainblack,),
                    ],
                  ),
                ),
                //SizedBox(height:10.0,),
                Text(errorText,style: TextStyle(color: Colors.red),),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    controller: _username,
                    autofillHints: const [ AutofillHints.username],
                    decoration: InputDecoration(
                      hintText: 'Username',
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Username cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                //SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _password,
                    obscureText: _obscureText,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                      hintText: 'Password',
                      //suffixIcon: Icon(Icons.visibility_off),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _obscureText=!_obscureText;
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Password Cannot be empty';
                      }
                      return null;
                    },


                  ),
                ),
               // SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(txt: 'Forget password?'),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(AppColor.bootProceedColor),
                          foregroundColor: WidgetStateProperty.all<Color>(AppColor.bootProceedColor),
                          overlayColor: WidgetStateProperty.all<Color>(AppColor.bootProceedColor),
                          shadowColor: WidgetStateProperty.all<Color>(AppColor.bootProceedColor),
                          elevation: WidgetStateProperty.all<double>(0.1),
                        ),

                        child: BigText(txt: 'Login',fontSize: 20,txtColor: AppColor.whiteColor,),
                        //color: Color(0xffEE7B23),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            TextInput.finishAutofillContext();
                            var datausername=_username.text.toString();
                            var datauserpassword=_password.text.toString();
                            print(datausername);
                            print(datauserpassword);
                            loginNow( datausername , datauserpassword);
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height:3.0),



              ],
            ),
          ),
        ),
      ),
    );
  }
}