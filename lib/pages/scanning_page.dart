import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:uparking/db_model/visit_info.dart';
import 'package:android_id/android_id.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/app_config.dart';
import '../../config/common_functions.dart';
import '../../constant/app_colors.dart';
import '../../constant/bar_text.dart';
import '../../db/sql_db_helper.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/loading_with_words.dart';
import '../../widgets/nav_drawer.dart';
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
class ScanningPage extends StatefulWidget {

  ScanningPage({super.key});

  @override
  State<ScanningPage> createState() => _ScanningPageState();
}

class _ScanningPageState extends State<ScanningPage> {
  //GoogleMapController? mapController;
  Set<Marker> markers = {};

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-33.86, 151.20);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Position? position;
  bool isProcessing=false;


  TextEditingController _vehicle= new TextEditingController();
  TextEditingController _latitude= new TextEditingController();
  TextEditingController _longtude= new TextEditingController();
  TextEditingController _note=new TextEditingController();
  TextEditingController _myFarmerField=new TextEditingController();
  List<Map<String,dynamic>> reasonData=[];
  List<Map<String,dynamic>> farmers=[];
  List<Map<String,dynamic>> placeData=[];
  List<Map<String,dynamic>>? multDropdown;


  ///set preference


  List<DropdownMenuItem<String>> getDropDownMenuItemAndValue(List<Map<String, dynamic>> querysetdata ) {
   // print(querysetdata);
    List<DropdownMenuItem<String>>  data=  querysetdata.map(
            (e) =>
            DropdownMenuItem(value: (e['table_id']).toString(),
                child: Text(e['name'])) //DropDownValueModelList.fromJson(e)
    ).toList();
    data.add(DropdownMenuItem( value: ('').toString(),child:Text( '---Select---')));
    return data;
  }



  ///DOWNLOAD TICKETS
  Future<void> _goParking(String vehicleNo,String action) async {

    setState(() {
      isProcessing=true;
    });
    //var parDataUrl='?vehicleNo='+vehicleNo+'&action='+action;
    //var urlData=AppConfig.go_parking+parDataUrl;
    //var response = await CommonFunction.getHttpRequest(urlData);
    String? accessToken = await AppConfig.getAccessToken();
    var response = await http.post(
        Uri.parse(AppConfig.go_parking),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
        body: jsonEncode({'vehicleNo': vehicleNo.toString(),'action':action})
    );


    print(response.body);

    if (response.statusCode == 200) {
      //await SQLHelper.deleteAlInhouseGrades();



      if (isProcessing == true) {
        setState(() {
          isProcessing = false;
        });
      }

      //AppConfig.successToast("Grades are successfully downloaded");
      CommonFunction.customSnack(context,"${vehicleNo} are successfully parking gone",1);



    } else {

      if (isProcessing == true) {
        setState(() {
          isProcessing = false;
        });
      }
      CommonFunction.customSnack(context,"${vehicleNo} failed to be downloaded.Please try again",0);

      //AppConfig.errorToast("Grades failed to be downloaded.Please try again");
    }
  }


  ///DATA
  @override
  initState() {
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    print('farmers ${farmers.length}');

    return Scaffold(
      //appBar: commonAppBar(title: "${isTransportingShipment?'TRANSPORTING':'RECEIVING'} ${shipment_no}"),
      drawer: NavDrawer(),
      appBar:AppBar(
        leading: IconButton(onPressed: () {
          //CommonFunction.transionRoute(context, AmcosMainPage(amcosId: amcosId.toString(),code:amcosCode.toString(),name:amcosName.toString()));

        }, icon:  Icon(Icons.arrow_back_ios_new_rounded, color:AppColor.whiteColor,size: 30.0,)),

        backgroundColor: AppColor.maincolor,
          title: BigText(txt:'PARKING PAGE',fontSize: 17,txtColor: AppColor.whiteColor,),
          actions: [
          //IconButton(onPressed: () {}, icon:  Icon(Icons.arrow_back, color:AppColor.whiteColor,size: 30.0,)),

          ],
      ),

    //MainBaseAppBar(title: "${amcosCode !=null?'${amcosCode}-${amcosName}':'AMCOS/FARMER VISIT'}",appBar: AppBar(),backWhere: 'amcos-main',),

      body:isProcessing? LoadingIndicatorOnly():createData(),
    );


  }
  ///CREATE ONE
  Widget createData()  {
    print('onbuild');
    print(farmers);

    ///works on receiving and transporting
    return  SingleChildScrollView(
      physics: PageScrollPhysics(),

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
           // Padding(padding:EdgeInsets.all(20),child: BigText(txt: widget.visitId == 0?'Register a Visit ':'Update',txtColor: AppColor.mainblack,fontSize: 20,)),
            Divider(
              color: AppColor.deepmaincolor,
            ),
            //Padding(padding:EdgeInsets.all(20),child: BigText(txt: '${''}-New',txtColor: AppColor.deepmaincolor,fontSize: 20,)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Icon(Icons.car_repair_sharp,size: 100,)),
              ],
            ),
            Divider(
              color: AppColor.deepmaincolor,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height:10,),
                  BigText(txt: 'Vehicle Number',fontSize: 18,),
                  Padding(padding: EdgeInsets.all(2),
                      child:TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                  RegExp(r'\s')),
                            UpperCaseTextFormatter(),
                          ],
                        readOnly: false,
                          controller: _vehicle,
                        //editing controller of this TextField
                          decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                  color: Colors.black,

                                ),
                              ),
                              //  prefix:BigText(txt:'T',txtColor: AppColor.maincolor,) ,
                              //icon: Icon(Icons.calendar_today), //icon of text field
                              //labelText: "Latitude ",
                             // hintText: "Latitude"//label text of field
                          ),

                          //keyboardType: TextInputType.number,
                          //inputFormatters: [carNumberMask],
                          //readOnly: true,  // when true user cannot edit text
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter vihicle number';
                            }
                            return null;
                          }
                      )
                  ),

                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.maincolor,
                        minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                      ),

                      child: BigText(txt:'GO',fontSize: 17,txtColor: AppColor.whiteColor,),

                      onPressed: () async {
                        print('Imebonyezwa');
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          print('Validated');
                          print('_vehicle');

                          print(_vehicle.text);
                          await _goParking(_vehicle.text.toString(),'in');

                        }

                      },

                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget viewData()  {
    print('onbuild');
    print(farmers);

    ///works on receiving and transporting
    return  SingleChildScrollView(
      physics: PageScrollPhysics(),

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Divider(
              color: AppColor.deepmaincolor,
            ),
          Padding(padding:EdgeInsets.all(20),child: BigText(txt: '${''}-visit',txtColor: AppColor.deepmaincolor,fontSize: 20,)),
            Divider(
              color: AppColor.deepmaincolor,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                BigText(txt: 'Farmers Visited',fontSize: 19,),
                  BigTextOverFlow(txt: '${_myFarmerField.text} '),





                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Visited Place',fontSize: 18,),
                      BigTextOverFlow(txt: '${_vehicle}'),
                    ],
                  ),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Visited Reason',fontSize: 18,),
                      BigTextOverFlow(txt: '${_vehicle}'),
                    ],
                  ),
                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Latitude',fontSize: 18,),
                      BigTextOverFlow(txt: '${_latitude.text}'),
                    ],
                  ),
                  SizedBox(height:10,),

                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Longitude',fontSize: 18,),
                      BigTextOverFlow(txt: '${_longtude.text}'),
                    ],
                  ),
                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),


                  SizedBox(height:10,),

                  SizedBox(height:20,),

                  BigText(txt: 'Remarks',fontSize: 18,),
                  BigText(txt: 'jedwhh jhewhejhw dhjfehjfd hjjhdfhjfd gtgyween gewghwe'),

                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),


                  SizedBox(height:10,),
                  ///
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: MediaQuery.of(context).size.height*0.3,

                    child:GoogleMap(
                      liteModeEnabled: true,     // the required field
                      mapToolbarEnabled: false,
                      initialCameraPosition: CameraPosition(

                        target: _center,
                        zoom: 11.0,
                      ),
                      markers: {
                        const Marker(
                          markerId: MarkerId('Sydney'),
                          position: LatLng(-33.86, 151.20),
                        )
                      },
                    ),
                  ),



                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getCurrentPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    //LocationPermission permission = await Geolocator.checkPermission();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position != null) setState(() {
      _latitude.text=position!.latitude.toString();
      _longtude.text=position!.longitude.toString();
    });




  }


}


