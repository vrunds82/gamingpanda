import 'package:flutter/material.dart';
import 'package:gamingpanda/CardsNew.dart';
import 'package:gamingpanda/Chat.dart';
import 'package:gamingpanda/about_you.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/Messages.dart';
import 'package:gamingpanda/filters.dart';
import 'package:gamingpanda/login.dart';
import 'package:gamingpanda/otherUserProfileDetails.dart';
import 'package:gamingpanda/profile.dart';
import 'package:gamingpanda/registration.dart';
import 'package:gamingpanda/settings.dart';
import 'package:gamingpanda/splash.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gamingpanda/website/webChatting.dart';
import 'package:gamingpanda/website/webRegistration.dart';
import 'package:gamingpanda/website/webSettingPage.dart';
import 'package:gamingpanda/website/webSplashScreen.dart';
import 'package:gamingpanda/website/webhome.dart';
import 'package:gamingpanda/website/weblogin.dart';
import 'package:overlay_support/overlay_support.dart';


import 'Home.dart';
import 'global.dart';
import 'livechat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gaming Panda',
        theme: ThemeData(
            scaffoldBackgroundColor: Global.isSwitchedFT == true
                ? Global.blackpanda
                : Global.whitepanda,
            //appBarTheme: AppBarTheme( color:  Global.isSwitchedFT==false?Global.blackpanda:Global.whitepanda,),
            fontFamily: "Schyler",
            textTheme: TextTheme(
              body1: TextStyle(fontSize: Global.fontsize),
              body2: TextStyle(fontSize: Global.fontsize),
              title: TextStyle(fontSize: Global.fontsize),
            ),
            primarySwatch: Colors.blue),
        home: splashscreen(),
        routes: {
          'login': (context) => loginpage(),
          'registerp': (context) => register(),
          'cardswipe': (context) => cardpage(),
          'profile': (context) => profilepage(),
          'Messages': (context) => Messages(),
          'livechat': (context) => livechatpage(),
          'settings': (context) => settingpage(),
          'filter': (context) => filteritem(),
          'editprofile': (context) =>aboutu(),
          'home':(context)=>Home(),
          'chat':(context)=>Chat(),
          'cardSwipeNew':(context)=> CardsNew(),
          'otherUserDetails':(context)=>OtherUserProfilePage(),
          'weblogin':(context)=>webloginpage(),
          'webRegistration':(context)=>WebRegister(),
          'webHome':(context)=>webHome(),
          'webSettingPage':(context)=>webSettingpage(),
          'webChattingPage':(context)=>webChatting()
        },
      ),
    );
  }
}
class MyApplication extends StatefulWidget {
  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  gettoken() async {
    await firebaseMessaging.getToken().then((token) {
      print("Token: $token");
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    gettoken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
