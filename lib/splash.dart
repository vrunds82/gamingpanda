import 'dart:async';
import 'dart:io';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  FirebaseMessaging firebaseMessaging=new FirebaseMessaging();
  startTime() async {


    await getSwitchState();
    FirebaseAuth.instance.currentUser().then((value) async {
      if(value!=null) {
        Global.User = value;
        print("Calling");
        await GetUserDeatils();
        Navigator.of(context).pushReplacementNamed('home');
      }else
        {
          var _duration = new Duration(seconds: 3);
          new Timer(_duration, navigationPage);
        }
    });
  }
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('login');
  }

  Future<bool> getSwitchState ()
  async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Global.isSwitchedFT = await prefs.get("theme")??true;
    print("Current Theme : "+Global.isSwitchedFT.toString());
    setState(() {

    });


  }

  @override
  Widget build(BuildContext context) {
    Global.height = MediaQuery.of(context).size.height;
    Global.width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo.png',height: MediaQuery.of(context).size.width*.4,width: MediaQuery.of(context).size.width*.4,)),


    );
  }

  ManageNotifications()async{
    firebaseMessaging.getToken().then((token){print(token);
    Global.token=token;});
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        //  var parsedJson = jsonDecode(message['notification']);

        print("onMessage awsef s : $message");
        if (Platform.isIOS) {
          //   toast("iOS");
          var parseddata = jsonDecode(message['notification']['data']);
          showSimpleNotification(
              Text( parseddata['name']+":"+ parseddata['content']),
              background: Colors.green);
        }else
        {
          //toast( ['data']);
          showSimpleNotification(
              Text( message['data']['name']+":"+message['data']['content']),
              background: Colors.green);
        }
      },
      onBackgroundMessage:await (Map<String, dynamic> message){
        myBackgroundMessageHandler(message,context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        Navigator.of(context).pushNamed('chat');
      },
      onResume: (Map<String, dynamic> message) async {

        Navigator.of(context).pushNamed('chat');
      },
    );

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ManageNotifications();
    startTime();
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message,context) {

  Navigator.of(context).pushNamed('chat');
  // Or do other work.
}