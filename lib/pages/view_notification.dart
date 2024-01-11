import 'package:cheerzclubvendor/cubit/notification/notification_cubit.dart';
import 'package:cheerzclubvendor/models/Notification.dart';
import 'package:cheerzclubvendor/pages/notification_list_page.dart';
import 'package:cheerzclubvendor/pages/order_details_page.dart';
import 'package:cheerzclubvendor/repository/notificationRepo.dart';
import 'package:cheerzclubvendor/utils/util.dart';
import 'package:cheerzclubvendor/widgets/cheerzAlert.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:cheerzclubvendor/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class View_notification_page extends StatefulWidget {
  final String? id;
  const View_notification_page({Key? key,this.id,}) : super(key: key);

  @override
  _View_notification_pageState createState() => _View_notification_pageState();
}

class _View_notification_pageState extends State<View_notification_page> {


  GlobalKey<ScaffoldState> _key = GlobalKey();

  SingleNotification? notification;

  late NotificationCubit notificationCubit;


  @override
  void initState() {
    notificationCubit = NotificationCubit(NotificatioNRepository());
    // TODO: implement initStat
    notificationCubit.GetoneNotif(widget.id!);
    //personal_message_Controller = TextEditingController(text: message);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("1A1B1D"),
      key: _key,
      endDrawer: drowerAfterlogin(),
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocProvider(
            create: (context) => notificationCubit,
            child: BlocListener<NotificationCubit,  NotificationState>(
              bloc: notificationCubit,
              listener: (context, state) {
                if (state is ViewnotifLoading) {}
                else if (state is ViewnotifSuccess) {
                  notification=state.notification;
                } else if (state is ViewnotifFail) {
                  Utils.showDialouge(context, AlertType.error, "Oops!", state.msg);
                }
              },
              child: BlocBuilder<NotificationCubit,  NotificationState>(
                  builder: (context, state) {
                    if (state is ViewnotifLoading) {
                      return Column(
                        children: const [
                          SizedBox(height: 410,),
                          Center(child: CupertinoActivityIndicator(radius: 10,),),
                        ],
                      );
                    } else if (state is ViewnotifSuccess) {
                      return  notificationdetailform();
                    } else if (state is  ViewnotifFail) {
                      return  notificationdetailform();
                    }
                    else {
                      return  notificationdetailform();
                    }
                  }),
            )),
      ),

    );
  }

  Widget notificationdetailform(){
    return Container(
      //color: HexColor("1A1B1D"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //Logo
          //Drawer
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
                      GestureDetector(
                        onTap: () {
                          _key.currentState!.openEndDrawer();
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


          //Back Button
          Container(
              margin: EdgeInsets.only(left: 20, top: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {

                      Navigator.push(context, PageTransition(
                          duration: Duration(milliseconds: 500),
                          type: PageTransitionType.leftToRight,
                          child:  Notification_page(),
                          inheritTheme: true,
                          ctx: context),);

                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 6),
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(24),
                          border:
                          Border.all(color: Colors.amber, width: 2)),
                      margin: EdgeInsets.only(right: 0, top: 0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.amber,
                          size: 12,
                        ),
                      ),
                    ),
                  ),



                ],
              )),


          SizedBox(height: 25,),

          InkWell(
            onTap: (){

              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => OrderDetails(
                    id: notification?.orderId.toString(),
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
              height: 30,
              padding: EdgeInsets.only(left: 20, right: 20),
              margin: EdgeInsets.only(top: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "#000${notification?.orderId}",
                    style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white,fontFamily: "Raleway" ),
                  ),
                  Expanded(child: SizedBox()),

                ],
              ),
            ),
          ),

          Container(
            height: 30,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: "${notification?.title}",
                    fontColor: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                Expanded(child: SizedBox()),
                CheersClubText(
                  text: "${notification?.time}",
                  fontColor: Colors.amber,
                  fontSize: 10,),

              ],
            ),
          ),

          Container(
            height: 300,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(text:"""${notification?.description}""""",
                  fontSize: 9, alignment:TextAlign.justify,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.white,

                ),

                Expanded(child: SizedBox()),
              ],
            ),
          ),



          SizedBox(height: 30,),
        ],
      ),
    );
  }



}
