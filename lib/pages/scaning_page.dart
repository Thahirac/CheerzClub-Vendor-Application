import 'dart:developer';

import 'package:cheerzclubvendor/cubit/productdetails/usercheck_cubit.dart';
import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/pages/dashboard.dart';
import 'package:cheerzclubvendor/pages/details_page.dart';
import 'package:cheerzclubvendor/repository/productdetailsRepo.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:cheerzclubvendor/widgets/drawer.dart';
import 'package:cheerzclubvendor/widgets/notification_icon.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';



class Scanpage extends StatefulWidget {
  @override
  _ScanpageState createState() => _ScanpageState();
}

class _ScanpageState extends State<Scanpage> {

  bool _isloading=false;
  bool _isloading2=false;
  GlobalKey<ScaffoldState>? _key = GlobalKey();
  DateTime? pre_backpress = DateTime.now();
  TextEditingController Username_Controller  = new TextEditingController();

  @override
  void initState() {
    Notification_Icon();
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      log("******BARCODE SECRET KEY******** $barcodeScanRes");

      if(barcodeScanRes!="-1"){
        Navigator.push(context, PageTransition(duration: Duration(milliseconds: 500), type: PageTransitionType.rightToLeft, child:  Detailspage(usersectret: barcodeScanRes,), inheritTheme: true, ctx: context),);
      }

      setState(() {
        _isloading2=false;
      });

    } on PlatformException {

      setState(() {
        _isloading2=false;
      });

      barcodeScanRes = 'Failed to get platform version.';
    }


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress!);

        final cantExit = timegap >= Duration(seconds: 2);

        pre_backpress = DateTime.now();

        if(cantExit){

          Fluttertoast.showToast(
              msg: AppLocalizations.of(context).translate("pate"),
              backgroundColor: Colors.amber,
              textColor: Colors.black,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              fontSize: 16.0
          );
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: HexColor("1A1B1D"),
        endDrawer: drowerAfterlogin(),
        resizeToAvoidBottomInset: false,
         key: _key,
          body:SafeArea(child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,

              child: scan())),

      ),
    );
  }


  Widget scan() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.2,
      color: HexColor("1A1B1D"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            child: Container(
              color: HexColor("131313"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 13, top: 25),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      "assets/images/cheerzclubvendorlogo1.png",
                      fit: BoxFit.fitHeight,
                      height: 55,
                      //width: 220,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10, top: 40),
                          child: Notification_Icon()),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _key!.currentState!.openEndDrawer();
                          //Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20, top: 40),
                          child: Image.asset(
                            "assets/images/nav.png",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      )
                    ],
                  )



                ],
              ),
            ),
          ),

          Container(
            height: 50,
            margin: EdgeInsets.only(left: 30, right: 30, top: 60),
            child: TextField(
              inputFormatters:  [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: Username_Controller,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context).translate('eusk'),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14,),
                filled: true,
                fillColor: HexColor("28292C"),
                // contentPadding: const EdgeInsets.only(left: 80.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("28292C")),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: HexColor("28292C")),
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
          ),


          ///continue button
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30,top: 20),
            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor("FEC753"), // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Container(
                  height: 40,
                  child: Center(
                    child:   _isloading? const Padding(padding: EdgeInsets.all(10.0), child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 1,color: Colors.black,)),): CheersClubText(
                      text: AppLocalizations.of(context).translate('cntn'),
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                onPressed: () {

                 // Userchek();

                  if(Username_Controller.text.isNotEmpty){

                    setState(() {
                      _isloading=true;
                    });

                    Navigator.push(context, PageTransition(duration: Duration(milliseconds: 500), type: PageTransitionType.rightToLeft, child:  Detailspage(usersectret: Username_Controller.text,), inheritTheme: true, ctx: context),);
                  }else{

                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context).translate("pftusf"),
                        backgroundColor: Colors.amber,
                        textColor: Colors.black);

                  }



                }
            ),
          ),

          /// Or
          Container(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 50,
                  //color: HexColor("FEC753"),
                  margin: EdgeInsets.only(left: 30, top: 20),
                  child:  Center(
                    child: CheersClubText(
                      text: AppLocalizations.of(context).translate('or'),
                      fontColor: Colors.amber,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),

          ///Scan User Secret key
          Container(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  margin: EdgeInsets.only(left: 30, top: 20),
                  child: Center(
                    child: CheersClubText(
                      text: AppLocalizations.of(context).translate('susk'),
                      fontColor: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///QR code image
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width* 0.5,
                  height: 200,
                 child:  Image.asset(
                   "assets/images/scan.gif",
                   fit: BoxFit.fill,
                 ),
                ),
              ],
            ),
          ),

          ///Scan button
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30,top: 35),
            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor("FEC753"), // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Container(
                  height: 40,
                  child: Center(
                    child:   _isloading2? Padding(padding: EdgeInsets.all(10.0), child: const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 1,color: Colors.black,)),): CheersClubText(
                      text: AppLocalizations.of(context).translate('SCAN'),
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              onPressed: () {

                setState(() {
                  _isloading2=true;
                });

                scanQR();



              }


            ),
          ),

          ///Scan result
          // Padding(
          //   padding: const EdgeInsets.only(top: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //
          //       Text('Scan result : $_scanBarcode\n', style: TextStyle(fontSize: 10)),
          //     ],
          //   ),
          // )

          // SizedBox(height: 100,),

        ],
      ),
    );

  }

  // Widget notificationIcon() {
  //   return Container(
  //     width: 30,
  //     height: 30,
  //     child: Stack(
  //       children: [
  //         const Icon(
  //           Icons.notifications_none,
  //           color: Colors.white,
  //           size: 28,
  //         ),
  //         Container(
  //           width: 27,
  //           height: 30,
  //           alignment: Alignment.topRight,
  //           margin: EdgeInsets.only(top: 0),
  //           child: Container(
  //             width: 15,
  //             height: 15,
  //             decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: HexColor("FFC853"),
  //                 border: Border.all(color: Colors.white, width: 1)),
  //             child: Padding(
  //               padding: const EdgeInsets.all(0.0),
  //               child: Center(
  //                 child: Text(
  //                  "0",
  //                   style: TextStyle(fontSize: 8, color: Colors.black),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

// void Userchek(){
//   usercheckCubit.checkorder(Username_Controller.text);
// }

}


