import 'package:cheerzclubvendor/cubit/productdetails/usercheck_cubit.dart';
import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/models/checkorder_class.dart';
import 'package:cheerzclubvendor/pages/dashboard.dart';
import 'package:cheerzclubvendor/pages/scaning_page.dart';
import 'package:cheerzclubvendor/repository/productdetailsRepo.dart';
import 'package:cheerzclubvendor/utils/util.dart';
import 'package:cheerzclubvendor/widgets/cheerzAlert.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:cheerzclubvendor/widgets/drawer.dart';
import 'package:cheerzclubvendor/widgets/notification_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class Detailspage extends StatefulWidget {
  final String? usersectret;

  const Detailspage({Key? key, this.usersectret}) : super(key: key);

  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {

  bool _isloading=false;
  DateTime? pre_backpress = DateTime.now();
  var table_controller = TextEditingController();


  String? _status;
  Color? clor;
  void statuschecking(item)async{
    if(item ==2){
      _status = AppLocalizations.of(context).translate("cncl");
      clor =Colors.red;
    }
    else if(item ==0){
      _status = AppLocalizations.of(context).translate("p");
      clor=Colors.amber;
    }
    else if(item ==1){
      _status = AppLocalizations.of(context).translate("c");
      clor=Colors.green;
    }
    else{
      _status = AppLocalizations.of(context).translate("p");
      clor=Colors.yellow;
    }
  }


  late UserchekCubit usercheckCubit;
  OrderedUser? orderedUser;
  Order? order;
  List<Orderitem>? orderitems;

  GlobalKey<ScaffoldState>? _key = GlobalKey();

  @override
  void initState() {
    usercheckCubit = UserchekCubit(OrderRepository());
    Notification_Icon();
    super.initState();
    usercheckCubit.checkorder(widget.usersectret);
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
        resizeToAvoidBottomInset: true,
        key: _key,
        body: SafeArea(
          child: BlocProvider(
              create: (context) => usercheckCubit,
              child: BlocListener<UserchekCubit, UsercheckState>(
                bloc: usercheckCubit,
                listener: (context, state) {
                  if (state is UsercheckInitial) {}
                  if (state is UsercheckLoading) {
                  } else if (state is UsercheckSuccessFull) {
                    orderedUser = state.orderedUser;
                    order = state.order;
                    orderitems = state.orderitems;
                  } else if (state is UsercheckFailed) {
                    Utils.showDialouge(
                        context, AlertType.error, "Oops!", state.msg);
                  }
                  else if (state is  DeliveryLoading) {}
                  else if (state is  DeliverySuccessFull) {
                    orderedUser = state.orderedUser;
                    order = state.order;
                    orderitems = state.orderitems;

                    // Fluttertoast.showToast(
                    //     msg: AppLocalizations.of(context).translate("od"),
                    //     backgroundColor: Colors.green,
                    //     textColor: Colors.white);

                    Utils.showDialouge(
                        context, AlertType.success, "Woow!", AppLocalizations.of(context).translate("od"));

                    setState(() {
                      _isloading=false;
                    });

                    Navigator.pushReplacement(
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
                        transitionDuration: Duration(milliseconds: 2000),
                      ),
                    );


                    // Navigator.pushReplacement(
                    //   context,
                    //   PageTransition(
                    //       duration: Duration(milliseconds: 500),
                    //       type: PageTransitionType.rightToLeft,
                    //       child: Dashboard(),
                    //       inheritTheme: true,
                    //       ctx: context),
                    // );


                  } else if (state is  DeliveryFailed) {
                    Utils.showDialouge(
                        context, AlertType.error, "Oops!", state.msg);

                    setState(() {
                      _isloading=false;
                    });

                  }
                },
                child: BlocBuilder<UserchekCubit, UsercheckState>(
                    builder: (context, state) {
                  // print("gjgfjhfjf" + cart_count.toString());
                  if (state is UsercheckInitial) {}
                  if (state is UsercheckLoading) {
                    return Column(
                      children:  [
                        SizedBox(
                          height: MediaQuery.of(context).size.height* 0.45,
                        ),
                        const Center(
                          child: CupertinoActivityIndicator(
                            radius: 10,
                          ),
                        ),
                      ],
                    );
                  } else if (state is UsercheckSuccessFull) {
                    return orderdetailsform();
                  } else if (state is UsercheckFailed) {
                    return orderdetailsform();
                  }
                  else if (state is DeliveryLoading) {
                    return orderdetailsform();
                  } else if (state is DeliverySuccessFull) {
                    return orderdetailsform();
                  } else if (state is DeliveryFailed) {
                    return orderdetailsform();
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

  Widget orderdetailsform() {
    return orderitems?.length == 0 || order?.deliveryDate==null
        ? Column(
            children:  [
              SizedBox(
                height: MediaQuery.of(context).size.height* 0.45,
              ),
               Center(
                child: CheersClubText(text: AppLocalizations.of(context).translate("nofh"),fontColor: Colors.white, fontWeight: FontWeight.w600, fontSize: 20,),
              ),
              const SizedBox(height: 20),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black,
                    primary: Colors.amber,
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child:  CheersClubText(
                      text: AppLocalizations.of(context).translate("rtsp"),
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () {

                    // Navigator.pushReplacement(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (c, a1, a2) =>  Dashboard(),
                    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    //       var begin = Offset(1.0, 0.0);
                    //       var end = Offset.zero;
                    //       var tween = Tween(begin: begin, end: end);
                    //       var offsetAnimation = animation.drive(tween);
                    //       return SlideTransition(
                    //         position: offsetAnimation,
                    //         child: child,
                    //       );
                    //     },
                    //     transitionDuration: Duration(milliseconds: 500),
                    //   ),
                    // );

                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (c, a1, a2) =>  Scanpage(),
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


                    // Navigator.pushReplacement(
                    //   context,
                    //   PageTransition(
                    //       duration: Duration(milliseconds: 500),
                    //       type: PageTransitionType.leftToRight,
                    //       child: Scanpage(),
                    //       inheritTheme: true,
                    //       ctx: context),
                    // );

                  },
                ),
              ),
            ],
          )
        : Container(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            // color: HexColor("1A1B1D"),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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

                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.leftToRight,
                              child: Scanpage(),
                              inheritTheme: true,
                              ctx: context),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 6),
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.amber, width: 2)),
                        margin: EdgeInsets.only(right: 0, top: 0, left: 20),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.amber,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),


                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30,top: 10,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheersClubText(
                          text: AppLocalizations.of(context).translate("mycart"),
                          fontColor: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 10,),

                        CheersClubText( text: AppLocalizations.of(context).translate("skey") + ":" + "${ order?.userSecret??""}",
                          fontSize: 12, alignment:TextAlign.justify,
                        ),

                        SizedBox(height: 5,),
                      ],
                    ),
                  ),

                  ///Customer Request
                  // order?.note==null?Container():Container(
                  //   padding: EdgeInsets.only(left: 30, right: 30,top: 20,),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       CheersClubText(
                  //         text: AppLocalizations.of(context).translate("cr"),
                  //         fontColor: Colors.amber,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //       SizedBox(height: 2,),
                  //
                  //       CheersClubText(text:"""${ order?.note??""}""",
                  //         fontSize: 10, alignment:TextAlign.justify,
                  //       ),
                  //
                  //       SizedBox(height: 5,),
                  //     ],
                  //   ),
                  // ),


                  ///my orders
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: BouncingScrollPhysics(),
                  //     itemCount: 1,
                  //     itemBuilder: (context, count) {
                  //      var tempDate = order?.deliveryDate.toString();
                  //       var correct = DateUtil().formattedDate(DateTime.parse(tempDate!));
                  //       statuschecking(order?.status);
                  //       return Container(
                  //         margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                  //         child: Column(
                  //           children: [
                  //             Container(
                  //               padding: EdgeInsets.all(10),
                  //               height: 57,
                  //               color: HexColor("464749"),
                  //               child: Row(
                  //                 children: [
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       CheersClubText(
                  //                         text: "${order?.name}",
                  //                         fontColor: Colors.amber,
                  //                         fontSize: 14,
                  //                       ),
                  //                       SizedBox(
                  //                         height: 4,
                  //                       ),
                  //                       CheersClubText(
                  //                         text:"${order?.id}",
                  //                         fontColor: Colors.white,
                  //                         fontSize: 11,
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Expanded(child: SizedBox()),
                  //                   Expanded(child: SizedBox()),
                  //                   Container(
                  //                     width: 80,
                  //                     height: 20,
                  //                     color: clor,
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.center,
                  //                       children: [
                  //                         CheersClubText(
                  //                           text: _status,
                  //                           fontColor: Colors.black,
                  //                           fontSize: 10,
                  //                         )
                  //                       ],
                  //                     ),
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             Container(
                  //               height: 90,
                  //               padding: EdgeInsets.all(10),
                  //               color: HexColor("2C2D2F"),
                  //               child: Row(
                  //                 children: [
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                       CheersClubText(
                  //                         text: AppLocalizations.of(context).translate("of"),
                  //                         fontColor: Colors.amber,
                  //                         fontSize: 14,
                  //                       ),
                  //                       const SizedBox(height: 8,),
                  //                       CheersClubText(
                  //                         text:"${orderedUser?.name}",
                  //                         fontColor: Colors.white,
                  //                         fontSize: 10,
                  //                       ),
                  //                       const SizedBox(height: 8,),
                  //                       CheersClubText(
                  //                         text: orderedUser?.address ?? "",
                  //                         fontColor: Colors.white,
                  //                         fontSize: 10,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Expanded(child: SizedBox()),
                  //                   Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     children: [
                  //                        CheersClubText(
                  //                         text: correct,
                  //                         fontColor: Colors.amber,
                  //                          fontSize: 14,
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 8,
                  //                       ),
                  //                       Row(
                  //                         children: [
                  //                           CheersClubText(
                  //                             text: "${orderedUser?.email}",
                  //                             fontColor: Colors.white,
                  //                             fontSize: 10,
                  //                           ),
                  //                           const SizedBox(height: 8,),
                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }),

                  ///beginig of products
                  Container(
                    color: HexColor("5D5D5E"),
                    height: 40,
                    margin:
                        EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Table(
                          children:  [
                            TableRow(
                              children: [
                                CheersClubText(
                                    text:"""${ AppLocalizations.of(context).translate("des")}""",
                                    alignment:TextAlign.justify,
                                    fontColor: Colors.amber,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                                CheersClubText(
                                    text: AppLocalizations.of(context).translate("qty"),
                                    fontColor: Colors.amber,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///products
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: orderitems?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: Table(
                            border:  TableBorder(
                              bottom: BorderSide(color: Colors.grey.shade800,width: 0.5),
                            ),
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20, bottom: 15,top:15),
                                  child: CheersClubText(
                                      text:"""${orderitems?[index].productName??""}""",
                                      alignment:TextAlign.justify,
                                      fontColor: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, bottom: 15,top:15),
                                  child: CheersClubText(
                                      text: "${orderitems?[index].quantityText}",
                                      fontColor: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: CheersClubText(
                      text: AppLocalizations.of(context).translate("tbl"),
                      fontColor: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 4),
                    child: TextField(
                      inputFormatters:  [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      controller: table_controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                        filled: true,
                        fillColor: HexColor("28292C"),
                        contentPadding:
                        const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
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

                  ///deliver
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 60),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("FEC753"), // background
                          onPrimary: Colors.black, // foreground
                        ),
                        child: Container(
                          height: 40,
                          child: Center(
                            child: _isloading? Padding(padding: const EdgeInsets.all(10.0), child: const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(strokeWidth: 1,color: Colors.black,)),): CheersClubText(
                              text: AppLocalizations.of(context).translate("dlr"),
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onPressed: () {

                          if(table_controller.text.isNotEmpty){

                            setState(() {
                              _isloading=true;
                            });

                            delivey();
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: AppLocalizations.of(context).translate("pfttf"),
                                backgroundColor: Colors.amber,
                                textColor: Colors.black);
                          }


                        }),
                  ),

                   SizedBox(height: MediaQuery.of(context).size.height*0.5,),
                ],
              ),
            ),
          );
  }


  void delivey() {

    usercheckCubit.orderdelivery(order?.userSecret, order?.restaurantSecret,table_controller.text);
  }
}

class DateUtil {
  String formattedDate(DateTime dateTime) {
    return DateFormat.yMMMEd().format(dateTime);
  }
}
