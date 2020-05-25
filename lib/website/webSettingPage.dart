import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/about_you.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/Messages.dart';
import 'package:gamingpanda/filters.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/SwipeUser.dart';
import 'package:gamingpanda/profile.dart';
import 'package:gamingpanda/settings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class webSettingpage extends StatefulWidget {
  @override
  _webSettingpageState createState() => _webSettingpageState();
}

class _webSettingpageState extends State<webSettingpage> {





  void callback(){
    setState(() {
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Global.webCurrentPageIndex=0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Global.isSwitchedFT == true ? Colors.black : Global.whitepanda,
      body: Row(
        children: [
          Container(
            color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
            child: SizedBox(
              width: Global.webwidth*.25,
              child:  settingpage(),
            ),
          ),
          Expanded(child:  Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
                child: SizedBox(
                  width: Global.webwidth*.25,
                  child:  aboutu(),
                ),
              ),
            ),
          )),
          Container(
            color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
            child: SizedBox(
              width: Global.webwidth*.25,
              child:  filteritem(),
            ),
          ),
        ],
      ),
    );
  }

  myViews(){
    switch (Global.webCurrentPageIndex){
      case 0:
        return cardpage();
      case 1:
        return Center(child: Text("asdfaseras"));
      case 2:
        return Messages();
    }
  }

}
