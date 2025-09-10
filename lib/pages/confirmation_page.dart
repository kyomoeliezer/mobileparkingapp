import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:uparking/pages/scanning_page.dart';
import 'package:uparking/pages/sumn_page.dart';
import '../config/common_functions.dart';
import '../constant/app_colors.dart';
import '../constant/bar_text.dart';
import 'action_select_page.dart';
class ConfirmationPage extends StatefulWidget {
  Map<String,dynamic> data;
  bool isExit;
   ConfirmationPage({super.key,required this.data,required this.isExit});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}


class _ConfirmationPageState extends State<ConfirmationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isProcessing=false;
  final SunmiPrinter sunmiPrinterPlus = SunmiPrinter();



  @override
  void initState() {
    final SunmiPrinter sunmiPrinterPlus = SunmiPrinter();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(onPressed: () {
          CommonFunction.transionRoute(context, ActionSelectPage());

        }, icon:  Icon(Icons.arrow_back_ios_new_rounded, color:AppColor.whiteColor,size: 30.0,)),

        backgroundColor: AppColor.maincolor,
        title: BigText(txt:'CONFIRMATION',fontSize: 17,txtColor: AppColor.whiteColor,),
        actions: [
          //IconButton(onPressed: () {}, icon:  Icon(Icons.arrow_back, color:AppColor.whiteColor,size: 30.0,)),

        ],
      ),
      body: viewData(),


    );
  }

  Widget viewData()  {
    print('onbuild');

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               // widget.isExit ?Padding(padding:EdgeInsets.all(20),child: BigText(txt: '${widget.data['carNo']}',txtColor: widget.isExit ?AppColor.bootDangerColor:AppColor.bootProceedColor,fontSize: 40,)):Padding(padding:EdgeInsets.all(20),child: BigText(txt: '${widget.data['carNo']}',txtColor: widget.isExit ?(widget.data['billingPaymentStatus']=='PAID') & (widget.data['billingAmount']!=null )?AppColor.successColor:AppColor.bootProceedColor:AppColor.bootProceedColor,fontSize: 40,)),

                widget.isExit ?Padding(padding:EdgeInsets.all(20),child: BigText(txt: '${widget.data['carNo']}',txtColor: (widget.data['billingPaymentStatus']=='PAID') & (widget.data['billingAmount']!=null )?AppColor.successColor:AppColor.bootDangerColor,fontSize: 40,)):SizedBox.shrink(),
                !widget.isExit ?Padding(padding:EdgeInsets.all(20),child: BigText(txt: '${widget.data['carNo']}',txtColor:(widget.data['billingPaymentStatus']=='PAID') & (widget.data['billingAmount']!=null )? AppColor.bootProceedColor:AppColor.bootDangerColor,fontSize: 40,)):SizedBox.shrink(),
              ],
            ),
            Divider(
              color: AppColor.deepmaincolor,
            ),
            widget.isExit ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.isExit?Padding(padding:EdgeInsets.all(20),child: BigText(txt:((widget.data['billingPaymentStatus'] == null))? 'HAJALIPA':'${(widget.data['billingPaymentStatus'])}',txtColor: (widget.data['billingPaymentStatus']=='PAID') & (widget.data['billingAmount']!=null )?AppColor.successColor:AppColor.bootDangerColor,fontSize: 30,)):
                Padding(padding:EdgeInsets.all(20),child: BigText(txt:((widget.data['billingPaymentStatus'] == null) & !widget.isExit)? 'HAJALIPA':'',txtColor: AppColor.bootDangerColor,fontSize: 30,)),
              ],
            ):SizedBox.shrink(),
            widget.isExit ?Divider(
              color: AppColor.deepmaincolor,
            ):SizedBox.shrink(),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height:10,),


                  SizedBox(height:20,),
                  widget.isExit ?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        (widget.data['billingPaymentStatus']==null) & (widget.data['billingAmount']!=null )? Column(
                          children: [
                            Icon(Icons.clear_rounded,size: 100,color: AppColor.bootDangerColor,),
                            BigText(txt: 'HAJALIPA BADO',txtColor: AppColor.bootDangerColor,fontSize: 30,)
                          ],
                        ): SizedBox.shrink(),
                        (widget.data['billingPaymentStatus']=='PAID') & (widget.data['billingAmount']!=null )? Icon(Icons.check_circle,size: 100,color: AppColor.successColor,): SizedBox.shrink(),

                    ],
                  ):Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (widget.data['billingPaymentStatus']==null) & (widget.data['billingAmount']!=null )? Column(
                        children: [
                          Icon(Icons.clear_rounded,size: 100,color: AppColor.bootDangerColor,),
                          BigText(txt: 'HAJALIPA BADO',txtColor: AppColor.bootDangerColor,fontSize: 30,)
                        ],
                      ): SizedBox.shrink(),
                      (widget.data['billingPaymentStatus']=='PAID') & (widget.data['billingAmount']!=null )? Icon(Icons.check_circle,size: 100,color: AppColor.successColor,): SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Kuingia ',fontSize: 18,),
                      BigTextOverFlow(txt: '${widget.data['parked_at']}'),
                    ],
                  ),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Billed at',fontSize: 18,),
                      BigTextOverFlow(txt: '${widget.data['billingAt'] !=null?widget.data['billingAt']:'----'}'),
                    ],
                  ),
                  SizedBox(height:10,),

                  SizedBox(height:10,),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Charged',fontSize: 18,),
                      BigTextOverFlow(txt: widget.data['billingAmount']==null?'---':'${widget.data['billingAmount']}'),
                    ],
                  ),
                  Divider(height: 10,color: AppColor.defaultIconColor,),
                  SizedBox(height:20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(txt: 'Payment status',fontSize: 18,),
                      BigTextOverFlow(txt: widget.data['billingPaymentStatus']==null?'---':'${widget.data['billingPaymentStatus']}'),
                    ],
                  ),
                  SizedBox(height:30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(onPressed:(){
                        CommonFunction.transionRoute(context, ActionSelectPage());

                      }, icon:Icon(Icons.exit_to_app_outlined) ,label: BigText(txt: 'ANZA UPYA',txtColor: AppColor.whiteColor,),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.bootProceedColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 100,),

                      ElevatedButton.icon(onPressed:() async{
                        Sunmi printer = Sunmi();
                        printer.printReceipt2(widget.data);
                      }, icon:Icon(Icons.exit_to_app_outlined) ,label: BigText(txt: 'Print',txtColor: AppColor.whiteColor,),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.successColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  )





                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
