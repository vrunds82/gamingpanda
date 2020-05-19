import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/chat.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Padding(
                      padding: const EdgeInsets.only(top:14.0,bottom: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(onTap: (){
                            Global.currentpageindex = 0;
                            setState(() {});
                          },
                            child: Image.asset(
                              Global.currentpageindex == 0
                                  ? 'assets/images/userorange.png'
                                  : 'assets/images/usergrey.png',
                              height: MediaQuery.of(context).size.width * Global.IconSize,
                              width: MediaQuery.of(context).size.width * Global.IconSize,
                              fit: BoxFit.contain,),
                          ),
                          GestureDetector(onTap: (){
                            Global.currentpageindex = 1;
                            setState(() {});
                          },
                            child: Image.asset(
                              Global.currentpageindex == 1
                                  ? 'assets/images/pandaorange.png'
                                  : 'assets/images/pandagrey.png',
                              height: MediaQuery.of(context).size.width *  Global.IconSize,
                              width: MediaQuery.of(context).size.width *  Global.IconSize,
                              fit: BoxFit.contain,  ),
                          ),

                          GestureDetector(onTap: (){
                            Global.currentpageindex = 2;
                            setState(() {});
                          },
                            child: Image.asset(   Global.currentpageindex == 2
                                ? 'assets/images/chatorange.png'
                                : 'assets/images/chatgrey.png',
                              height: MediaQuery.of(context).size.width *  Global.IconSize,
                              width: MediaQuery.of(context).size.width *  Global.IconSize,
                              fit: BoxFit.contain,   ),
                          ),

                        ],
                      ),
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
              child:  myViews(),
            )
          ],
        ),
      ),
    );
  }

  myViews(){
    switch (Global.currentpageindex){
      case 0:
        return profilepage();
      case 1:
        return cardpage();
      case 2:
        return chatscreen();
    }
  }

}
