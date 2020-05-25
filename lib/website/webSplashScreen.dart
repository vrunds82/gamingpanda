import 'dart:async';
import 'dart:io';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/global.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class webSplashScreen extends StatefulWidget {
  @override
  _webSplashScreenState createState() => _webSplashScreenState();
}

class _webSplashScreenState extends State<webSplashScreen> {

  startTime() async {


    await getSwitchState();
    FirebaseAuth.instance.currentUser().then((value) async {
      if(value!=null) {
        Global.User = value;
        print("Calling");
        await GetUserDeatils();
        Navigator.of(context).pushNamed('weblogin');
      }else
      {
        var _duration = new Duration(seconds: 3);
        new Timer(_duration, navigationPage);
      }
    });
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
    // TODO: implement initState
    super.initState();

    startTime();
  }
}

