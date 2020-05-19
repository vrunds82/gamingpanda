import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/cards.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';

import 'global.dart';

class cardpage extends StatefulWidget {
  @override
  _cardpageState createState() => _cardpageState();
}

class _cardpageState extends State<cardpage> {

  static final List<Profile> demoProfiles = [
    new Profile(
        photos: [
          'http://admin.mysuitors.com/uploads/20190419093131am.jpg',
          'http://admin.mysuitors.com/uploads/20190419093204am.jpg',
          'http://admin.mysuitors.com/uploads/20190419093131am.jpg',
        ],
        name: 'Someone Special',
        bio: 'This is the person you want!',
        id: "1"
    ),
    new Profile(
        photos: [
          'http://admin.mysuitors.com/uploads/20190419093131am.jpg',
          'http://admin.mysuitors.com/uploads/20190419093204am.jpg',
          'http://admin.mysuitors.com/uploads/20190419093131am.jpg',
        ],
        name: 'Someone Special',
        bio: 'This is the person you want!',
        id:"2"
    ),
  ];
 List<DateMatch> UserMatches = new List();
  MatchEngine matchEngine ;


  void initState() {
    // TODO: implement initState
    print(demoProfiles);
    super.initState();

    matchEngine = new MatchEngine(
      matches: demoProfiles.map((Profile profile) {
        return new DateMatch(profile: profile);
      }).toList(),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.isSwitchedFT == true
          ? Global.blackpanda
          : Global.whitepanda,
      body: Column(
        children: <Widget>[
       /*   CustomAppbar(),*/
          Expanded(
            child: CardStack(
              matchEngine: matchEngine,),
            /*child: Padding(
              padding: const EdgeInsets.fromLTRB(4,4,4,4),
              child: ClipRRect(borderRadius: BorderRadius.all(
                Radius.circular(20)
              ),
                child: Image.asset('assets/images/user.png', 
                  fit: BoxFit.cover, 
                ),
              ),
            ),*/
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25,top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  matchEngine.currentMatch.nope();
                },
                  child: Image.asset('assets/images/cancel.png',height: 45,width: 45,),
                ),

                GestureDetector(
                    onTap: (){
                      matchEngine.currentMatch.superLike();
                    },child: Image.asset('assets/images/star.png',height: 45,width: 45,)),

                GestureDetector(
                  onTap: (){
                    matchEngine.currentMatch.like();
                  },child: Image.asset('assets/images/gamebtn.png',height: 45,width: 45,)),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
