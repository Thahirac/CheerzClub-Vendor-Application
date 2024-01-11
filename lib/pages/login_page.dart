// ignore_for_file: file_names


import 'package:cheerzclubvendor/cubit/login/login_cubit.dart';
import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/pages/scaning_page.dart';
import 'package:cheerzclubvendor/repository/LoginRepository.dart';
import 'package:cheerzclubvendor/utils/util.dart';
import 'package:cheerzclubvendor/widgets/cheerzAlert.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';


class LoginScreen extends StatefulWidget {
  // final String? token;
  const LoginScreen({Key? key,}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isloading=false;
  DateTime? pre_backpress = DateTime.now();
  var Username_Controller = TextEditingController();
  var Password_Controller = TextEditingController();
  String? _password = "";
  String? _username = "";
  bool _isObscure = true;
  bool value = false;
  GlobalKey<ScaffoldState>? _key = GlobalKey();
  late LoginCubit loginCubit;
  @override
  void initState() {
    // TODO: implement initState
    loginCubit = LoginCubit(UserLoginRepository());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Username_Controller.dispose();
    Password_Controller.dispose();
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
        key: _key,
        //endDrawer: drowerBeforlogin(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocProvider(
                create: (context) => loginCubit,
                child: BlocListener<LoginCubit, LoginState>(
                  bloc: loginCubit,
                  listener: (context, state) {
                    if (state is LoginLoading) {}
                    if (state is LoginSuccessFull) {

                      Fluttertoast.showToast(
                          msg: AppLocalizations.of(context).translate("ls"),
                          backgroundColor: Colors.green,
                          textColor: Colors.white);

                      setState(() {
                        _isloading=false;
                      });

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


                      // Navigator.push(context,
                      //   PageTransition(
                      //       duration: Duration(milliseconds: 500),
                      //       type: PageTransitionType.rightToLeft,
                      //       child:  Scanpage(),
                      //       inheritTheme: true,
                      //       ctx: context),
                      // );
                    } else if (state is LoginFailed) {
                      Utils.showDialouge(
                          context, AlertType.error, "Oops!", state.msg);

                      setState(() {
                        _isloading=false;
                      });

                    }
                  },
                  child:
                  BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
                    return loginform();
                  }),
                )),
          ),
        ),
      ),
    );
  }

  Widget loginform() {
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



                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, top: 30),
            child: const CheersClubText(
              text: "Login",
              fontColor: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 35),
            child: TextField(
              controller: Username_Controller,
              onChanged: (val) {
                _username = val;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your Email or username',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                filled: true,
                fillColor: HexColor("28292C"),
                contentPadding: const EdgeInsets.only(
                    left: 14.0, bottom: 6.0, top: 8.0),
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
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: TextField(
              controller: Password_Controller,
              obscureText: _isObscure,
              onChanged: (VAL) {
                setState(() {
                  _password = VAL;
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ?Icons.visibility_off : Icons.visibility  ,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                border: InputBorder.none,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                filled: true,
                fillColor: HexColor("28292C"),
                contentPadding: const EdgeInsets.only(
                    left: 14.0, bottom: 0.0, top: 8.0),
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
          Container(
            margin: EdgeInsets.only(left: 20, right: 30, top: 20),
            child: Row(
              children: [
                Checkbox(
                  activeColor: HexColor("FEC753"),
                  side: BorderSide(color: Colors.white),
                  checkColor: Colors.white,
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 0, top: 0),
                  child: const CheersClubText(
                    text: "Remember Login",
                    fontColor: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          ///Login button
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
                    child:  _isloading? Padding(padding: const EdgeInsets.all(10.0), child: const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 1,color: Colors.black,)),): const CheersClubText(
                      text: "Continue",
                      fontColor: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                onPressed: () {

                  setState(() {
                    _isloading=true;
                  });

                  login();
                }

            ),
          ),



          // /// Forgot password
          // InkWell(
          //   onTap: () {
          //     // Navigator.push(context, PageTransition(duration: Duration(milliseconds: 1000), type: PageTransitionType.rightToLeft, child: forgetPassword(), inheritTheme: true, ctx: context),);
          //   },
          //   child: Container(
          //     height: 50,
          //     child: Row(
          //       children: [
          //         Container(
          //           width: MediaQuery.of(context).size.width - 60,
          //           height: 50,
          //           //color: HexColor("FEC753"),
          //           margin: EdgeInsets.only(left: 30, top: 10),
          //           child: Center(
          //             child: const CheersClubText(
          //               text: "Forgot Password",
          //               fontColor: Colors.amber,
          //               fontWeight: FontWeight.w600,
          //               fontSize: 14,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 30, top: 20),
          //   child: const CheersClubText(
          //     text: "Or Login With",
          //     fontColor: Colors.white,
          //     fontWeight: FontWeight.w600,
          //     fontSize: 15,
          //   ),
          // ),
          // /// Google sign
          // Padding(
          //   padding: const EdgeInsets.only(left: 30, right: 30,top: 20),
          //   child:  ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: Colors.white, // background
          //         onPrimary: Colors.black, // foreground
          //       ),
          //       child: Container(
          //         height: 40,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //
          //             Container(
          //               height: 40,
          //               width: 40,
          //               padding: EdgeInsets.only(
          //                 top: 10,
          //                 bottom: 10,
          //               ),
          //               child: Image.asset(
          //                 "assets/images/google.png",
          //                 height: 36,
          //                 width: 36,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //
          //
          //             const CheersClubText(
          //               text: "Google",
          //               fontColor: Colors.black,
          //               fontWeight: FontWeight.w600,
          //               fontSize: 14,
          //             ),
          //
          //             SizedBox(
          //               width: 20,
          //             )
          //           ],
          //         ),
          //       ),
          //       onPressed: () {
          //         //Navigator.push(context, PageTransition(duration: Duration(milliseconds: 1000), type: PageTransitionType.rightToLeft, child:  Scanpage(), inheritTheme: true, ctx: context),);
          //       }
          //
          //   ),
          // ),
          // ///Facebook sign
          // Padding(
          //   padding: const EdgeInsets.only(left: 30, right: 30,top: 5),
          //   child:  ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: HexColor("3A559F"), // background
          //         onPrimary: Colors.white, // foreground
          //       ),
          //       child: Container(
          //         height: 40,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //
          //             Container(
          //               height: 40,
          //               width: 40,
          //               padding: EdgeInsets.only(
          //                 top: 10,
          //                 bottom: 10,
          //               ),
          //               child: Image.asset(
          //                 "assets/images/fb.png",
          //                 height: 36,
          //                 width: 36,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //
          //
          //             const CheersClubText(
          //               text: "Facebook",
          //               fontColor: Colors.white,
          //               fontWeight: FontWeight.w600,
          //               fontSize: 14,
          //             ),
          //
          //             SizedBox(
          //               width: 20,
          //             )
          //           ],
          //         ),
          //       ),
          //       onPressed: () {
          //         //Navigator.push(context, PageTransition(duration: Duration(milliseconds: 1000), type: PageTransitionType.rightToLeft, child:  Scanpage(), inheritTheme: true, ctx: context),);
          //       }
          //
          //   ),
          // ),
          // ///Instagram sign
          // Padding(
          //   padding: const EdgeInsets.only(left: 30, right: 30,top: 5),
          //   child:  ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary:  HexColor("ED58C0"), // background
          //         onPrimary: Colors.white, // foreground
          //       ),
          //       child: Container(
          //         height: 40,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //
          //             Container(
          //               height: 40,
          //               width: 40,
          //               padding: EdgeInsets.only(
          //                 top: 10,
          //                 bottom: 10,
          //               ),
          //               child: Image.asset(
          //                 "assets/images/insta.png",
          //                 height: 36,
          //                 width: 36,
          //                 fit: BoxFit.contain,
          //               ),
          //             ),
          //
          //
          //             const CheersClubText(
          //               text: "Instagram",
          //               fontColor: Colors.white,
          //               fontWeight: FontWeight.w600,
          //               fontSize: 14,
          //             ),
          //
          //             SizedBox(
          //               width: 20,
          //             )
          //           ],
          //         ),
          //       ),
          //       onPressed: () {
          //         //Navigator.push(context, PageTransition(duration: Duration(milliseconds: 1000), type: PageTransitionType.rightToLeft, child:  Scanpage(), inheritTheme: true, ctx: context),);
          //       }
          //
          //   ),
          // ),


          // SizedBox(height: 100,),

        ],
      ),
    );

  }

  void login() {
    loginCubit.authenticateUser(
        Username_Controller.text, Password_Controller.text);
  }


}

