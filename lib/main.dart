import 'package:flutter/material.dart';
import 'package:gamingpanda/about_you.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/chat.dart';
import 'package:gamingpanda/filters.dart';
import 'package:gamingpanda/login.dart';
import 'package:gamingpanda/profile.dart';
import 'package:gamingpanda/registration.dart';
import 'package:gamingpanda/settings.dart';
import 'package:gamingpanda/splash.dart';

import 'global.dart';
import 'livechat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
        'chat': (context) => chatscreen(),
        'livechat': (context) => livechatpage(),
        'settings': (context) => settingpage(),
        'filter': (context) => filteritem(),
      },
    );
  }
}
