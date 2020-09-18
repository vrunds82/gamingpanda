import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/CardsNew.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/Messages.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/SwipeUser.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:gamingpanda/profile.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {


@override
void dispose() {

  super.dispose();
}
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.inactive:
      print("Inactive");


      // Global.MainMusicPlayer.pause();
      break;
    case AppLifecycleState.paused:
      print("Paused");

      //Global.MainMusicPlayer.pause();
      break;
    case AppLifecycleState.resumed:
      print("Resumed");

      setState(() {

      });
      //Global.MainMusicPlayer.play();
      break;
    case AppLifecycleState.detached:


      break;


  }
}


  void callback(){
    setState(() {

    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{

        if(Global.currentpageindex==1){
          return true;
        }else{
          Global.currentpageindex=1;
          setState(() {

          });
          return false;
        }


      },
      child: Scaffold(
        backgroundColor:
        Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    //height: MediaQuery.of(context).size.width * .2,
                    color: Global.isSwitchedFT==true?Global.darkBlue:Global.whitepanda ,
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[


                          GestureDetector(onTap: (){
                            Global.currentpageindex = 0;
                            setState(() {});
                          },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  Global.currentpageindex == 0
                                      ? 'assets/images/userorange.png'
                                      : 'assets/images/usergrey.png',
                                  height: MediaQuery.of(context).size.width * Global.IconSize,
                                  width: MediaQuery.of(context).size.width * Global.IconSize,
                                  fit: BoxFit.contain,),
                              ),
                            ),
                          ),
                          GestureDetector(onTap: (){
                            Global.currentpageindex = 1;
                            setState(() {});
                          },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  Global.currentpageindex == 1
                                      ? 'assets/images/pandaorange.png'
                                      : 'assets/images/pandagrey.png',
                                  height: MediaQuery.of(context).size.width *  Global.IconSize,
                                  width: MediaQuery.of(context).size.width *  Global.IconSize,
                                  fit: BoxFit.contain,  ),
                              ),
                            ),
                          ),

                          GestureDetector(onTap: (){
                            Global.currentpageindex = 2;
                            setState(() {});
                          },
                            child: Container(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(   Global.currentpageindex == 2
                                    ? 'assets/images/chatorange.png'
                                    : 'assets/images/chatgrey.png',
                                  height: MediaQuery.of(context).size.width *  Global.IconSize,
                                  width: MediaQuery.of(context).size.width *  Global.IconSize,
                                  fit: BoxFit.contain,   ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Global.isSwitchedFT?0:0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
              Expanded(
                child: myViews()
              )
            ],
          ),
        ),
      ),
    );
  }
/*
  PageView(
  controller: controller,
  onPageChanged: (value){
  Global.currentpageindex=value;
  setState(() {

  });
  },
  children: [


  profilepage(callback: this.callback),
  cardpage(),
  chatscreen(),
  ],
  )*/

  myViews(){
    switch (Global.currentpageindex){
      case 0:
        return profilepage(callback: this.callback);
      case 1:
        return CardsNew(callback: this.callback,);
      case 2:
        return Messages();
    }
  }

}
