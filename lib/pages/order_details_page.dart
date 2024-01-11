import 'package:cheerzclubvendor/cubit/vieworder/view_order_cubit.dart';
import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/models/Singleorder_class.dart';
import 'package:cheerzclubvendor/repository/VieworderRepo.dart';
import 'package:cheerzclubvendor/utils/util.dart';
import 'package:cheerzclubvendor/widgets/cheerzAlert.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:cheerzclubvendor/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class OrderDetails extends StatefulWidget {
  final String? id;
  final String? date;


  const OrderDetails({Key? key,this.id,this.date}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {


  String? _status;
  // 1 - Paid,      2- Refunded,   0-Failed
  void statuschecking(item, item1) async {
    if (item == 0 && item1 == 0) {
      _status =  AppLocalizations.of(context).translate("cncl");
    } else if (item == 0 && item1 == 1) {
      _status = AppLocalizations.of(context).translate("p");
    } else if (item == 0 && item1 == 2) {
      _status = AppLocalizations.of(context).translate("p");
    } else if (item == 1 && item1 == 1) {
      _status = AppLocalizations.of(context).translate("c");
    } else if (item == 2 && item1 == 0) {
      _status =  AppLocalizations.of(context).translate("cncl");
    } else if (item == 2 && item1 == 1) {
      _status =  AppLocalizations.of(context).translate("cncl");
    } else if (item == 2 && item1 == 2) {
      _status =  AppLocalizations.of(context).translate("cncl");
    } else {
      _status = AppLocalizations.of(context).translate("p");
    }
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();
  late MyorderCubit myorderCubit;
  List<Orderitem>? orderitems;
  OrderedUser? orderedUser;
  Order? order;
  dynamic total;
  String? restId;

  @override
  void initState() {
    myorderCubit = MyorderCubit(GetOneOrder());
    // TODO: implement initStat
    restId = widget.id!.toString();
    myorderCubit.GetoneOrderGet(restId.toString());
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
            create: (context) => myorderCubit,
            child: BlocListener<MyorderCubit, MyorderState>(
              bloc:  myorderCubit,
              listener: (context, state) {
                if (state is MyorderInitial) {}
                if (state is MyorderLoading) {

                } else if (state is MyorderSuccess) {

                  orderedUser=state.orderedUser;
                  order=state.order;
                  orderitems=state.orderitems;
                  total=state.total;


                } else if (state is MyorderFail) {
                  Utils.showDialouge(context, AlertType.error, "Oops!", state.msg);
                }
              },
              child: BlocBuilder<MyorderCubit, MyorderState>(
                  builder: (context, state) {
                    // print("gjgfjhfjf" + cart_count.toString());
                    if (state is MyorderInitial) {
                      return Column(
                        children: [
                          SizedBox(height: 390,),
                          Center(child: CupertinoActivityIndicator(radius: 10,),),
                        ],
                      );
                    }
                    if (state is MyorderLoading) {
                      return Column(
                        children: [
                          SizedBox(height: 410,),
                          Center(child: CupertinoActivityIndicator(radius: 10,),),
                        ],
                      );
                    } else if (state is MyorderSuccess) {
                      return  orderdetailform();
                    } else if (state is  MyorderFail) {
                      return  orderdetailform();
                    }
                    else {
                      return  orderdetailform();
                    }
                  }),
            )),
      ),

    );
  }

  Widget orderdetailform(){
    statuschecking(order?.status,order?.paymentStatus);
    var tempDate = order?.createdAt.toString();
    var correct = DateUtil().formattedDate(DateTime.parse(tempDate!));
    var tempDate1 = order?.deliveryDate.toString();
    var correct1 = DateUtil().formattedDate(DateTime.parse(tempDate1!));
    return _status=="Accepted" || _status=="Accepté" || _status=="Aceptado" || _status=="Angenommen" || _status=="Geaccepteerd"?
    Container(
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

                      Navigator.pop(context);

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


          Container(
            height: 35,
            padding: EdgeInsets.only(left: 20, right: 20,top: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                  text: AppLocalizations.of(context).translate("i") + " :  #000${restId}",
                  fontColor: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(child: SizedBox()),

              ],
            ),
          ),
          Container(
            height: 15,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("skey") + " : ${order?.userSecret}",
                    fontColor: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
              ],
            ),
          ),

          Container(
            height: 15,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("id") + " : "+ correct,
                    fontColor: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
              ],
            ),
          ),


          Container(
            height: 15,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("sts") + " : ",
                    fontColor: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                CheersClubText(
                    text: "${_status}",
                    fontColor: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),

              ],
            ),
          ),

          // Container(
          //   height: 40,
          //   padding: EdgeInsets.only(left: 20, right: 20,top: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: AppLocalizations.of(context).translate("invto"),
          //           fontColor: Colors.white,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w700),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 20,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: orderedUser?.name??"",
          //           fontColor: Colors.white,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 20,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: orderedUser?.email??"",
          //           fontColor: Colors.white,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 40,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(text:"""${orderedUser?.address??""}""",
          //         fontSize: 12, alignment:TextAlign.justify,
          //           fontWeight: FontWeight.w500,
          //         fontColor: Colors.white,
          //
          //       ),
          //
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),


          //beginig of kart

          Container(
            color: HexColor("5D5D5E"),
            height: 40,
            margin: EdgeInsets.only(top: 18, bottom: 4),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Table(
                  children: [
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
                        CheersClubText(
                            text: AppLocalizations.of(context).translate("pr"),
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

          //kart description
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderitems?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Table(
                    border: TableBorder(
                      bottom: BorderSide(color: Colors.grey.shade900, width: 0.5),
                    ),
                    children: [
                      TableRow(
                          children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20, bottom: 15,top:15),
                          child:  CheersClubText(
                              text:"""${orderitems?[index].productName??""}""",
                                     fontSize: 11, alignment:TextAlign.justify,
                            fontColor: Colors.white,
                              fontWeight: FontWeight.w500
                               ),

                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10, bottom: 15,top:15),
                          child: CheersClubText(
                              text: "${orderitems?[index].quantityText}",
                              fontColor: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),

                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10,bottom: 15,top:15),
                              child: CheersClubText(
                                  text: orderitems?[index].itemPrice.toStringAsFixed(2).toString()??"",
                                  fontColor: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),


                      ]),
                    ],
                  ),
                );
              },
            ),
          ),

        /*  //Transaction fee
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                  text: AppLocalizations.of(context).translate("tfee"),
                  fontColor: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                          text: "${transactionfee}",
                          fontColor: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                )
              ],
            ),
          ),

          //Sub Total
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("stotal"),
                    fontColor: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                          text:"${subtotal}",
                          fontColor: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                )
              ],
            ),
          ),


          //Vat21
          //Vat9
          vat21==null? Container() :Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("vat21"),
                    fontColor: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                        text: '${vat21}',
                        fontColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          vat9==null? Container() :Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("vat9"),
                    fontColor: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                        text: '${vat9}',
                        fontColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),



          // SizedBox(height: 50,),

          // widget.pstatus==2 || widget.pstatus==0 ? Container(): Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Container(
          //         decoration: BoxDecoration(border: Border.all(color: Colors.white,width:2)),
          //         height: 120,
          //         width: 120,
          //      child:
          //         ProgressiveImage(
          //           baseColor: Colors.grey.shade200,
          //           highlightColor: Colors.grey.shade50,
          //           height: 120,
          //           width: 120,
          //           fit: BoxFit.contain,
          //           image: order!.qr.toString(),
          //           imageError: "assets/images/euro.png",
          //
          //         ),
          //
          //         // child: Image.network(order!.qr.toString(),fit: BoxFit.contain,)
          //     ),
          //   ],
          // ),

          // SizedBox(height: 3,),
          //
          // widget.pstatus==2 || widget.pstatus==0 ? Container() : Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text("${order?.userSecret}",style: TextStyle(fontSize: 8,fontStyle: FontStyle.italic),),
          //   ],
          // ),


          //Cancel Botton
          //QR Button
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //
          //
          //     widget.status==2 || widget.status==1 || widget.pstatus==0 ? Container(): Container(
          //       alignment: Alignment.center,
          //       child: RaisedButton(
          //         color: Colors.white,
          //         onPressed: () {
          //           cancelOrder();
          //         },
          //         child: Row(
          //           children: [
          //
          //             Icon(Icons.cancel_outlined,color: Colors.black,size: 13,),
          //
          //             SizedBox(
          //               width: 1,
          //             ),
          //             CheersClubText(
          //                 text: AppLocalizations.of(context).translate("cnclo"),
          //                 fontColor: Colors.black,
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.w600
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //     // SizedBox(width: 10,),
          //     //
          //     // widget.pstatus==2 || widget.pstatus==0 ? Container(): Container(
          //     //   alignment: Alignment.center,
          //     //   width: 133,
          //     //   child: RaisedButton(
          //     //     color: HexColor("FFC853"),
          //     //     onPressed: () {
          //     //
          //     //     },
          //     //     child: Row(
          //     //       children: [
          //     //
          //     //         Icon(Icons.qr_code,color: Colors.black,size: 13,),
          //     //
          //     //         SizedBox(
          //     //           width: 1,
          //     //         ),
          //     //         CheersClubText(
          //     //             text: " Download QR",
          //     //             fontColor: Colors.black,
          //     //             fontSize: 13,
          //     //             fontWeight: FontWeight.w600
          //     //         ),
          //     //       ],
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),*/

          //Total
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("total"),
                    fontColor: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                          text: total?.toStringAsFixed(2).toString()??"",
                          fontColor: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 30,),
        ],
      ),
    ):
    Container(
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

                      Navigator.pop(context);

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


          Container(
            height: 35,
            padding: EdgeInsets.only(left: 20, right: 20,top: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                  text: AppLocalizations.of(context).translate("o") + " : #000${restId}",
                  fontColor: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(child: SizedBox()),

              ],
            ),
          ),

          // Container(
          //   height: 30,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: "Secret Key" + ": ${order?.userSecret}",
          //           fontColor: Colors.white,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w500),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),

          Container(
            height: 15,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("ord") + " : " +  correct,
                    fontColor: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          Container(
            height: 15,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("dd") + " : ${correct1}",
                    fontColor: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
              ],
            ),
          ),

          Container(
            height: 15,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("sts") + " : ",
                    fontColor: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                CheersClubText(
                    text: "${_status}",
                    fontColor: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),

          // Container(
          //   height: 40,
          //   padding: EdgeInsets.only(left: 20, right: 20,top: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: AppLocalizations.of(context).translate("of"),
          //           fontColor: Colors.white,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w700),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 20,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: orderedUser?.name??"",
          //           fontColor: Colors.white,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 20,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(
          //           text: orderedUser?.email??"",
          //           fontColor: Colors.white,
          //           fontSize: 12,
          //           fontWeight: FontWeight.w500),
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),
          // Container(
          //   height: 40,
          //   padding: EdgeInsets.only(left: 20, right: 20),
          //   margin: EdgeInsets.only(top: 0, bottom: 0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CheersClubText(text:"""${orderedUser?.address??""}""",
          //         fontSize: 12, alignment:TextAlign.justify,
          //         fontWeight: FontWeight.w500,
          //         fontColor: Colors.white,
          //
          //       ),
          //
          //       Expanded(child: SizedBox()),
          //     ],
          //   ),
          // ),


          //beginig of kart

          Container(
            color: HexColor("5D5D5E"),
            height: 40,
            margin: EdgeInsets.only(top: 20, bottom: 4),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Table(
                  children: [
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
                        CheersClubText(
                            text: AppLocalizations.of(context).translate("pr"),
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

          //kart description
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderitems?.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Table(
                    border: TableBorder(
                      bottom: BorderSide(color: Colors.grey.shade900, width: 0.5),
                    ),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20, bottom: 15,top:15),
                          child: CheersClubText(
                              text:"""${orderitems?[index].productName??""}""",
                              alignment:TextAlign.justify,
                              fontColor: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10,  bottom: 15,top:15),
                          child: CheersClubText(
                              text: "${orderitems?[index].quantityText}",
                              fontColor: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10,  bottom: 15,top:15),
                          child: CheersClubText(
                              text: orderitems?[index].itemPrice.toStringAsFixed(2).toString()??"",
                              fontColor: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),

                      ]),
                    ],
                  ),
                );
              },
            ),
          ),

          /*  //Transaction fee
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                  text: AppLocalizations.of(context).translate("tfee"),
                  fontColor: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                          text: "${transactionfee}",
                          fontColor: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                )
              ],
            ),
          ),

          //Sub Total
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("stotal"),
                    fontColor: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                          text:"${subtotal}",
                          fontColor: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                )
              ],
            ),
          ),


          //Vat21
          //Vat9
          vat21==null? Container() :Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("vat21"),
                    fontColor: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                        text: '${vat21}',
                        fontColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          vat9==null? Container() :Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("vat9"),
                    fontColor: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                        text: '${vat9}',
                        fontColor: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),


  //Total
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
            margin: EdgeInsets.only(top: 0, bottom: 0),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CheersClubText(
                    text: AppLocalizations.of(context).translate("total"),
                    fontColor: Colors.amber,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                Expanded(child: SizedBox()),
                Container(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/euro.png",
                        height: 10,
                        width: 10,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CheersClubText(
                          text: "${order?.price}",
                          fontColor: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ],
                  ),
                )
              ],
            ),
          ),


          // SizedBox(height: 50,),

          // widget.pstatus==2 || widget.pstatus==0 ? Container(): Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Container(
          //         decoration: BoxDecoration(border: Border.all(color: Colors.white,width:2)),
          //         height: 120,
          //         width: 120,
          //      child:
          //         ProgressiveImage(
          //           baseColor: Colors.grey.shade200,
          //           highlightColor: Colors.grey.shade50,
          //           height: 120,
          //           width: 120,
          //           fit: BoxFit.contain,
          //           image: order!.qr.toString(),
          //           imageError: "assets/images/euro.png",
          //
          //         ),
          //
          //         // child: Image.network(order!.qr.toString(),fit: BoxFit.contain,)
          //     ),
          //   ],
          // ),

          // SizedBox(height: 3,),
          //
          // widget.pstatus==2 || widget.pstatus==0 ? Container() : Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text("${order?.userSecret}",style: TextStyle(fontSize: 8,fontStyle: FontStyle.italic),),
          //   ],
          // ),


          //Cancel Botton
          //QR Button
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //
          //
          //     widget.status==2 || widget.status==1 || widget.pstatus==0 ? Container(): Container(
          //       alignment: Alignment.center,
          //       child: RaisedButton(
          //         color: Colors.white,
          //         onPressed: () {
          //           cancelOrder();
          //         },
          //         child: Row(
          //           children: [
          //
          //             Icon(Icons.cancel_outlined,color: Colors.black,size: 13,),
          //
          //             SizedBox(
          //               width: 1,
          //             ),
          //             CheersClubText(
          //                 text: AppLocalizations.of(context).translate("cnclo"),
          //                 fontColor: Colors.black,
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.w600
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //
          //     // SizedBox(width: 10,),
          //     //
          //     // widget.pstatus==2 || widget.pstatus==0 ? Container(): Container(
          //     //   alignment: Alignment.center,
          //     //   width: 133,
          //     //   child: RaisedButton(
          //     //     color: HexColor("FFC853"),
          //     //     onPressed: () {
          //     //
          //     //     },
          //     //     child: Row(
          //     //       children: [
          //     //
          //     //         Icon(Icons.qr_code,color: Colors.black,size: 13,),
          //     //
          //     //         SizedBox(
          //     //           width: 1,
          //     //         ),
          //     //         CheersClubText(
          //     //             text: " Download QR",
          //     //             fontColor: Colors.black,
          //     //             fontSize: 13,
          //     //             fontWeight: FontWeight.w600
          //     //         ),
          //     //       ],
          //     //     ),
          //     //   ),
          //     // ),
          //   ],
          // ),*/


          SizedBox(height: 30,),
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