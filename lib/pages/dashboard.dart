import 'package:cheerzclubvendor/cubit/dashboard/dashboard_cubit.dart';
import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/models/dashboar_class.dart';
import 'package:cheerzclubvendor/pages/order_details_page.dart';
import 'package:cheerzclubvendor/pages/scaning_page.dart';
import 'package:cheerzclubvendor/repository/dashboardRepo.dart';
import 'package:cheerzclubvendor/utils/util.dart';
import 'package:cheerzclubvendor/widgets/cheerzAlert.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:cheerzclubvendor/widgets/drawer.dart';
import 'package:cheerzclubvendor/widgets/notification_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  String? _status;
  Color? clor;
  void statuschecking(item)async{
    if(item ==2){
      _status = AppLocalizations.of(context).translate("cncl");
      clor =Colors.red;
    }
    else if(item ==0){
      _status = AppLocalizations.of(context).translate("p");
      clor=Colors.red;
    }
    else if(item ==1){
      _status = AppLocalizations.of(context).translate("c");
      clor=Colors.green;
    }
    else{
      _status = AppLocalizations.of(context).translate("p");
      clor=Colors.red;
    }
  }


  late DashbordCubit dashbordCubit;

  GlobalKey<ScaffoldState>? _key = GlobalKey();
  var Username_Controller = TextEditingController();
  String? _username = "";
  String _scanBarcode = 'Unknown';

  List<Order> OrderListdata = [];

  void OrdersLoading() {
    dashbordCubit.getOrders();
  }

  @override
  void initState() {
    dashbordCubit = DashbordCubit(DashBordRepository());
    Notification_Icon();
    OrdersLoading();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("1A1B1D"),
      endDrawer: drowerAfterlogin(),
      resizeToAvoidBottomInset: false,
      key: _key,
      body:SafeArea(
          child: SingleChildScrollView(
          child:   BlocProvider(
              create: (context) => dashbordCubit,
              child: BlocListener<DashbordCubit, DashbordState>(
                bloc: dashbordCubit,
                listener: (context, state) {
                  if (state is DashbordLoadingMyorders) {}

                  else if (state is DashbordLoadingMyordersSucssellfull) {
                    OrderListdata = state.orders!;
                  }
                  else if (state is DashbordLoadingMyordersFail) {

                    Utils.showDialouge(context, AlertType.error, "Oops!", state.msg);
                  }
                },
                child: BlocBuilder<DashbordCubit, DashbordState>(
                    builder: (context, state) {
                      if (state is DashbordLoadingMyorders) {
                        return Column(
                          children: const [
                            SizedBox(height: 390,),
                            Center(child: CupertinoActivityIndicator(radius: 10,),),
                          ],
                        );
                      }

                      if (state is DashbordLoadingMyordersSucssellfull) {
                        return mydarshboard();
                      } else if (state is DashbordLoadingMyordersFail) {
                        return mydarshboard();
                      }
                      else {
                        return Container();
                      }
                    }),
              )),
      ),
      ),

    );
  }









  Widget mydarshboard() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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


          ///Scan button
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30,top: 20,bottom: 8),
            child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape:  RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(1.0),
                  ),
                  primary: HexColor("FEC753"), // background
                  onPrimary: Colors.black, // foreground
                ),
                child: Container(
                  height: 45,
                  child: Center(
                    child: CheersClubText(
                      text: AppLocalizations.of(context).translate('SCAN'),
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => Scanpage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                    ),
                  );


                }


            ),
          ),

          ///MY ORDER
          Container(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 45,
                  color: HexColor("FEC753"),
                  margin: EdgeInsets.only(
                      left: 30, bottom: 15, right: 30),
                  child: Center(
                    child: CheersClubText(
                      text: AppLocalizations.of(context).translate('MY ORDERS'),
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),


          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: OrderListdata.length,
                itemBuilder: (context, count) {
                  var tempDate = OrderListdata[count].deliveryDate.toString();
                  var correct = DateUtil().formattedDate(DateTime.parse(tempDate));
                  statuschecking(OrderListdata[count].status,);


                  return GestureDetector(
                    onTap: (){

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (c, a1, a2) => OrderDetails(
                            id: OrderListdata[count].id.toString(),
                            date: correct,
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var tween = Tween(begin: begin, end: end);
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500),
                        ),
                      );



                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 57,
                            color: HexColor("464749"),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CheersClubText(
                                      text: OrderListdata[count].name??"",
                                      fontColor: Colors.amber,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    CheersClubText(
                                        text: "" + OrderListdata[count].id.toString(),
                                        fontColor: Colors.white,
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                Expanded(child: SizedBox()),
                                Container(
                                  width: 90,
                                  height: 20,
                                  color:  clor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CheersClubText(
                                        text:  _status.toString(),
                                        fontColor: Colors.black,
                                        fontSize: 9.5,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 70,
                            padding: EdgeInsets.all(10),
                            color: HexColor("2C2D2F"),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CheersClubText(
                                      text: correct,
                                      fontColor: Colors.amber,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                     "",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/euro.png",
                                          height: 8,
                                          width: 8,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        CheersClubText(
                                          text:  OrderListdata[count].price!.toStringAsFixed(2).toString(),
                                            fontColor: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),




          // SizedBox(height: 100,),

        ],
      ),
    );

  }

  Widget notificationIcon() {
    return Container(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          Icon(
            Icons.notifications_none,
            color: Colors.white,
            size: 28,
          ),
          Container(
            width: 27,
            height: 30,
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 0),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor("FFC853"),
                  border: Border.all(color: Colors.white, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 8, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class DateUtil {
  String formattedDate(DateTime dateTime) {
    return DateFormat.yMMMEd ().format (dateTime);
  }
}
