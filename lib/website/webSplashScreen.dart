import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/global.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';


class webSplashScreen extends StatefulWidget {
  @override
  _webSplashScreenState createState() => _webSplashScreenState();
}

class _webSplashScreenState extends State<webSplashScreen> {

  FirebaseMessaging firebaseMessaging;
  startTime() async {


    await getSwitchState();
    User value =
   FirebaseAuth.instance.currentUser;

    if(value!=null) {
      Global.firebaseUser = value;
      print("Calling");
      await GetUserDeatils();
      Navigator.of(context).pushNamed('weblogin');
    }else
    {
      var _duration = new Duration(seconds: 3);
      new Timer(_duration, navigationPage);
    }

  }
  void navigationPage() {
    Navigator.of(context).pushNamed('weblogin');
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

    Global.isweb = true;
    Global.webwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo.png',height: MediaQuery.of(context).size.height*.3,width: MediaQuery.of(context).size.height*.3,)),
    );
  }

  @override
  void initState() {
  /*  ManageNotifications();*/
    startTime();
    // TODO: implement initState
    super.initState();


  }

  /*ManageNotifications()async{



    print("Taking Token");


   await firebaseMessaging.getToken().then((token){
      print(token);
    Global.token=token;});
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        //  var parsedJson = jsonDecode(message['notification']);

        print("onMessage awsef s : $message");
        if (Platform.isIOS) {
          //   toast("iOS");
           await firebaseMessaging.requestNotificationPermissions();

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

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        Navigator.of(context).pushNamed('chat');
      },
      onResume: (Map<String, dynamic> message) async {

        Navigator.of(context).pushNamed('chat');
      },
    );

  }
*/
}

