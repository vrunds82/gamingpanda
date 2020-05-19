import 'dart:async';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

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

    Global.isSwitchedFT = await prefs.get("theme")??false;
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
  }@override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTime();
  }
}

