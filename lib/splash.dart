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

  FirebaseMessaging firebaseMessaging;



  startTime() async {
    await getTotalUsers();
    await ManageNotifications();
    await getSwitchState();

    User value = FirebaseAuth.instance.currentUser;

    if(value!=null) {
      print(value);
      Global.firebaseUser = value;
      print("Calling ${Global.firebaseUser.uid}");
      await GetUserDeatils();

      Future.delayed(Duration.zero,(){
        Navigator.of(context).pushReplacementNamed('home');
      });


    }else
    {
      var _duration = new Duration(seconds: 3);
      new Timer(_duration, navigationPage);
    }

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


    FirebaseMessaging.instance.getToken().then((token){print(token);
    Global.token=token;});


    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        print("onMessage awsef s : $message");
        var parseddata = message.data;
        if (Platform.isIOS) {
          //   toast("iOS");

          showSimpleNotification(
              Text( parseddata['name']+":"+ parseddata['content']),
              background: Colors.green);
        }else
        {
          //toast( ['data']);
          showSimpleNotification(
              Text(parseddata['name']+":"+parseddata['content']),
              background: Colors.green);
        }
      }
    });

   /* firebaseMessaging.configure(
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
     *//* onBackgroundMessage:await (Map<String, dynamic> message){
        myBackgroundMessageHandler(message,context);
      },*//*
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        Navigator.of(context).pushNamed('chat');
      },
      onResume: (Map<String, dynamic> message) async {

        Navigator.of(context).pushNamed('chat');
      },
    );*/

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTime();
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message,context) {

  Navigator.of(context).pushNamed('chat');
  // Or do other work.
}