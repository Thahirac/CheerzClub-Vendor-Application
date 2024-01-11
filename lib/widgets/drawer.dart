
import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/pages/dashboard.dart';
import 'package:cheerzclubvendor/pages/faq.dart';
import 'package:cheerzclubvendor/pages/details_page.dart';
import 'package:cheerzclubvendor/pages/login_page.dart';
import 'package:cheerzclubvendor/pages/privacy_statements.dart';
import 'package:cheerzclubvendor/pages/scaning_page.dart';
import 'package:cheerzclubvendor/pages/settings.dart';
import 'package:cheerzclubvendor/pages/termsand_conditions.dart';
import 'package:cheerzclubvendor/utils/user_manager.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';



class drowerAfterlogin extends StatefulWidget {
  const drowerAfterlogin({Key? key}) : super(key: key);

  @override
  _drowerAfterloginState createState() => _drowerAfterloginState();
}

class _drowerAfterloginState extends State<drowerAfterlogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          color: HexColor("1A1B1D"),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
      child: Column(
        children: [
          Container(
            height: 120,
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
                      height: 45,
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
                          margin: EdgeInsets.only(right: 20, top: 40),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.amber,
                              size: 12,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),


          ///DASHBOARD
          GestureDetector(
            onTap: () {

              Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child:  Dashboard(),
                    inheritTheme: true,
                    ctx: context),
              );

            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    height: 50,
                    color: HexColor("FEC753"),
                    margin: EdgeInsets.only(
                        left: 30, top: 30, bottom: 15, right: 30),
                    child:  Center(
                      child: CheersClubText(
                        text:  AppLocalizations.of(context).translate('MY DASHBOARD'),
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),


          ///SCAN
          InkWell(
            splashColor: Colors.amber,
            hoverColor: Colors.amber,
            focusColor: Colors.amber,
            onTap: () {

              Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child: Scanpage(),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(
                    width: 30,
                  ),
                  CheersClubText(
                    text:  AppLocalizations.of(context).translate('SCAN'),
                    fontColor: Colors.white,
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ),


          ///TERM AND CONDITIONS
          GestureDetector(
            onTap: (){

              Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child:  TermsandConditions(),
                    inheritTheme: true,
                    ctx: context),
              );

            },
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(
                    width: 30,
                  ),
                  CheersClubText(
                    text: AppLocalizations.of(context).translate('TERMS AND CONDITIONS'),
                    fontColor: Colors.white,
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ),

          ///PRIVACY STATMENT
          GestureDetector(
            onTap: (){

              Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child:  PrivacyStatements(),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(
                    width: 30,
                  ),
                  CheersClubText(
                    text: AppLocalizations.of(context)
                        .translate('PRIVACY STATEMENTS'),
                    fontColor: Colors.white,
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ),


          ///SETTINGS
          InkWell(
            splashColor: Colors.amber,
            hoverColor: Colors.amber,
            focusColor: Colors.amber,
            onTap: () {

              Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child: settings(),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(
                    width: 30,
                  ),
                  CheersClubText(
                    text:AppLocalizations.of(context).translate('SETTINGS'),
                    fontColor: Colors.white,
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ),



          ///FAQ
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child:  FaQ(),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  SizedBox(
                    width: 30,
                  ),
                  CheersClubText(
                    text: AppLocalizations.of(context).translate('FAQ'),
                    fontColor: Colors.white,
                    fontSize: 14,
                  )
                ],
              ),
            ),
          ),


          Expanded(child: SizedBox()),

          ///LOGOUT
          GestureDetector(
            onTap: () {
               UserManager.instance.logOutUser();


               Navigator.pushReplacement(
                 context,
                 PageRouteBuilder(
                   pageBuilder: (c, a1, a2) =>  LoginScreen(),
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

              // Navigator.push(
              //   context,
              //   PageTransition(
              //       duration: Duration(milliseconds: 500),
              //       type: PageTransitionType.rightToLeft,
              //       child: LoginScreen(),
              //       inheritTheme: true,
              //       ctx: context),
              // );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 50,
                    color: HexColor("FEC753"),
                    margin: EdgeInsets.only(
                        left: 30, top: 0, bottom: 15, right: 30),
                    child: Center(
                      child: CheersClubText(
                        text:  AppLocalizations.of(context).translate('LOG OUT'),
                        fontColor: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 40,)
        ],
      ),
    );
  }
}
