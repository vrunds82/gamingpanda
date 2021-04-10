import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/cards.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:gamingpanda/models/SwipeUser.dart';

import 'package:http/http.dart' as http;
import 'global.dart';

class cardpage extends StatefulWidget {

  Function callback;
  cardpage({this.callback});

  @override
  _cardpageState createState() => _cardpageState();
}

class _cardpageState extends State<cardpage> {



  void callback(){
    widget.callback();
  }


  bool loading = true;



  List<SwipeUser> Userslist = new List();
  List<Profile> UserProfiles = new List();
  List<DateMatch> UserMatches = new List();
  MatchEngine matchEngine ;




  GetAllUsers(){
loading = true;
    setState(() {

    });
    http.post(Uri.parse("${Global.BaseURL}filtered"),body: {"UserId":Global.firebaseUser.uid}).then((value) {
      dynamic parsedjson = jsonDecode(value.body);
      Userslist = (parsedjson as List).map((json) => SwipeUser.fromJson(json)).toList();
      print(Userslist.length);
      for (int i = 0; i < Userslist.length; i++) {
        List<String> pics = new List();

        if (Userslist[i].image1 != "" && Userslist[i].image1 != "null") {
          pics.add(Userslist[i].image1);
        }
        if (Userslist[i].image2 != "" && Userslist[i].image2 != "null") {
          pics.add(Userslist[i].image2);
        }
        if (Userslist[i].image3 != "" && Userslist[i].image3 != "null") {
          pics.add(Userslist[i].image3);
        }
        if (Userslist[i].image4 != "" && Userslist[i].image4 != "null") {
          pics.add(Userslist[i].image4);
        }
        if (Userslist[i].image5 != "" && Userslist[i].image5 != "null") {
          pics.add(Userslist[i].image5);
        }
        if (Userslist[i].image6 != "" && Userslist[i].image6 != "null") {
          pics.add(Userslist[i].image6);
        }

        if (pics.length != 0) {



          print(Userslist[i].game1);
          print(Games.indexOf(Userslist[i].game1));

          print(Userslist[i].game2);
          print(Games.indexOf(Userslist[i].game2));


          String games ="";

              if(Userslist[i].game1!="" && Games.indexOf(Userslist[i].game1)!=-1 ){
                games = ShortName[Games.indexOf(Userslist[i].game1)];

              }
              if(Userslist[i].game2!="" && Games.indexOf(Userslist[i].game1)!=-1){
                if(games==""){
                  games = ShortName[Games.indexOf(Userslist[i].game2)];
                }else{
                    games +=","+ ShortName[Games.indexOf(Userslist[i].game2)];
                  }
              }
          UserProfiles.add(new Profile(bio: Userslist[i].aboutUs,
              name: Userslist[i].userName,
              photos: pics,
              id: Userslist[i].userId,
              dp: Userslist[i].profilePicture,
              liked: Userslist[i].liked,
              age: (DateTime.now().year-Userslist[i].year).toString(),
              country: Userslist[i].country,
              games: games,
              gender: Userslist[i].gender
              ));
        }
      }

      matchEngine = new MatchEngine(
        matches: UserProfiles.map((Profile profile) {
          return new DateMatch(profile: profile);
        }).toList(),


      );
      loading = false;

      setState(() {

      });

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAllUsers();

  }

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


/*
  void initState() {
    // TODO: implement initState
    print(demoProfiles);
    super.initState();

    matchEngine = new MatchEngine(
      matches: demoProfiles.map((Profile profile) {
        return new DateMatch(profile: profile);
      }).toList(),
    );


  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Global.isweb?Colors.transparent:Global.isSwitchedFT == true
          ? Global.blackpanda
          : Global.whitepanda,
      body: Column(
        children: <Widget>[
       /*   CustomAppbar(),*/
          Expanded(
            child: loading?Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator()),):
            CardStack(
              Callback: this.callback,
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
                SizedBox(width: MediaQuery.of(context).size.width*.05,),
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
                SizedBox(width: MediaQuery.of(context).size.width*.05,),
              ],
            ),
          ),
        ],
      ),
    );
  }







}
