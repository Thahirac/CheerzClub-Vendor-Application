import 'package:cheerzclubvendor/localization/app_localization.dart';
import 'package:cheerzclubvendor/localization/language.dart';
import 'package:cheerzclubvendor/localization/language_const.dart';
import 'package:cheerzclubvendor/widgets/cheerzclub_text.dart';
import 'package:cheerzclubvendor/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool value1 = false;
  bool value2 = false;
  String? _chosenValue;
  String? lang;

  // changeLanguage(String language) {
  //   Locale _temp;
  //   switch (language) {
  //     case 'ENGLISH':
  //       _temp = Locale('en', 'US');
  //       break;
  //     case 'FRENCH':
  //       _temp = Locale('fr', 'FR');
  //       break;
  //     case 'NEDERLANDS':
  //       _temp = Locale('nl','NL');
  //       break;
  //     case 'GERMAN':
  //       _temp = Locale('de','DE');
  //       break;
  //     case 'SPANISH':
  //       _temp = Locale('es','ES');
  //       break;
  //     default:
  //       _temp = Locale('en', 'US');
  //   }
  //   MyApp.setLocale(context, _temp);
  // }
  // languageset(value)async{
  //   SharedPreferences preferences= await SharedPreferences.getInstance();
  //   preferences.setString('Chooselang', value.toString());
  //   //print("*Choose***lang**"+ preferences.getString('Chooselang').toString());
  //
  //   changeLanguage(value);
  // }
  //
  //
  // languageget()async{
  //   SharedPreferences preferences= await SharedPreferences.getInstance();
  //   print("*Choose***lang**"+ preferences.getString('Chooselang').toString());
  //
  //   setState(() {
  //     lang = preferences.getString('Chooselang');
  //     _chosenValue=lang==null?"ENGLISH":lang;
  //     changeLanguage(_chosenValue.toString());
  //   });
  //
  // }


  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // languageget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("1A1B1D"),
      key: _key,
      endDrawer: drowerAfterlogin(),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor("1A1B1D"),
        child: Container(
          width: MediaQuery.of(context).size.width,
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
              Container(
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 30,top: 20),
                      child: InkWell(
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
                              border: Border.all(color: Colors.amber, width: 2)),
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
                    ),
                    Expanded(child: SizedBox()),

                  ],
                ),
              ),


              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        height: 50,
                        color: HexColor("FEC753"),
                        margin: EdgeInsets.only(left: 30, top: 20),
                        child: Center(
                          child:  CheersClubText(
                            text:  AppLocalizations.of(context).translate('SETTINGS'),
                            fontColor: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(left: 30, top: 20, right: 20),
                child: Row(
                  children: [
                    CheersClubText(
                      text: AppLocalizations.of(context).translate("Allowallpushnotifications"),
                      fontSize: 14,
                      fontColor: Colors.white,
                    ),
                    Expanded(child: SizedBox()),
                    Checkbox(
                      activeColor: HexColor("FEC753"),
                      side: BorderSide(color: Colors.white),
                      checkColor: Colors.white,
                      value: this.value1,
                      onChanged: (bool? value) {
                        setState(() {
                          this.value1 = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),


              // Container(
              //   margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              //   child: Row(
              //     children: [
              //       CheersClubText(
              //         text: AppLocalizations.of(context).translate("Language"),
              //         fontSize: 14,
              //         fontColor: Colors.white,
              //         alignment: TextAlign.justify,
              //       ),
              //       Expanded(child: SizedBox()),
              //       Container(
              //         height: 46,
              //         width: 150,
              //         child: DropdownButtonFormField<String>(
              //           decoration: InputDecoration(
              //             enabledBorder: InputBorder.none,
              //           ),
              //           focusColor: Colors.black12,
              //           dropdownColor: Colors.black,
              //           value: _chosenValue,
              //           elevation: 5,
              //           style: TextStyle(color: Colors.black),
              //           iconEnabledColor: Colors.white,
              //           items: <String>[
              //             'ENGLISH',
              //             'FRENCH',
              //             'NEDERLANDS',
              //             'GERMAN',
              //             'SPANISH'
              //           ].map<DropdownMenuItem<String>>((String value) {
              //             return DropdownMenuItem<String>(
              //               // enabled: true,
              //               value: value,
              //               child: Text(
              //                 value,
              //                 style: TextStyle(
              //                     color: value == _chosenValue
              //                         ? Colors.white
              //                         : Colors.white,
              //                 ),
              //               ),
              //             );
              //           }).toList(),
              //           hint: Text(_chosenValue.toString(),
              //             style: TextStyle(
              //                 color: HexColor("FEC753"),
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500),
              //           ),
              //           onChanged: (String? value) {
              //
              //             setState(() {
              //               languageset(value);
              //             });
              //
              //
              //
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),


              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Row(
                  children: [
                    CheersClubText(
                      text: AppLocalizations.of(context).translate("Language"),
                      fontSize: 14,
                      fontColor: Colors.white,
                      alignment: TextAlign.justify,
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      child:  DropdownButton<Language>(
                        dropdownColor: Colors.black,
                        iconEnabledColor: Colors.white,
                        iconSize: 30,
                        hint: CheersClubText(text: AppLocalizations.of(context).translate("change_language"),
                            fontWeight: FontWeight.w500,
                            fontColor: HexColor("FEC753"),
                            fontSize: 14,
                            over: TextOverflow.ellipsis
                        ),
                        onChanged: (Language? language) {
                          _changeLanguage(language!);
                        },
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CheersClubText(text: e.flag,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Colors.white,
                                  fontSize: 23,
                                ),
                                CheersClubText(text: e.name,
                                  fontWeight: FontWeight.w500,
                                  fontColor: Colors.white,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
