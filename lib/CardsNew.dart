import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttery_dart2/layout.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/cardsLatest.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/SwipeUser.dart';


class CardsNew extends StatefulWidget {

  Function callback;
  CardsNew({this.callback});

  @override
  _CardsNewState createState() => _CardsNewState();
}

class _CardsNewState extends State<CardsNew> {

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
    http.post("${Global.BaseURL}filtered",body: {"UserId":Global.User.uid}).then((value) {
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
          UserProfiles.add(new
          Profile(bio: Userslist[i].aboutUs,
              name: Userslist[i].userName,
              photos: pics,
              id: Userslist[i].userId,
              dp: Userslist[i].profilePicture,
              liked: Userslist[i].liked,
              age: (DateTime.now().year-Userslist[i].year).toString(),
              country: Userslist[i].country,
              games: games,
              gender: Userslist[i].gender,
            disliked: Userslist[i].disliked,
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

  @override
  Widget build(BuildContext context) {

    Global.width =MediaQuery.of(context).size.width;
    Global.height=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Global.isweb?Colors.transparent:Global.isSwitchedFT == true
          ? Global.blackpanda
          : Global.whitepanda,
      body:   SizedBox(
        height: Global.isweb?Global.webwidth*.5: Global.height*.9,
        width: Global.isweb?Global.webwidth*.3: Global.width,
        child: Column(
          children: [
            Expanded(
              child: loading?Center(child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator()),):
                  UserProfiles.length>=2?new CardStack(
                Callback: this.callback,
                matchEngine: matchEngine,
              ):Center(child: CustomText(text:"No Users to Show",color: Global.orangepanda,),),

            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25,top: 25,right:Global.isweb?MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.15,left:Global.isweb?MediaQuery.of(context).size.width*0.04:MediaQuery.of(context).size.width*0.15),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          matchEngine.currentMatch.nope();
                        //  ActionsToUsers(action: "dislike",user1: Global.userData.userId,user2: matchEngine.currentMatch.profile.id);
                        },
                        child: Image.asset('assets/images/cancel.png',height: 50,width: 50,fit: BoxFit.fill,),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: GestureDetector(
                          onTap: () async {
                            matchEngine.currentMatch.superLike();
                            ActionsToUsers(action: "superlike",user1: Global.userData.userId,user2: matchEngine.currentMatch.profile.id);
                            await Future.delayed(Duration(milliseconds: 1000));
                            CreateChat(true);
                          },child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.asset('assets/images/star.png',height: 50,width: 50,fit: BoxFit.fill),
                          )),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: GestureDetector(
                          onTap: () async {
                            matchEngine.currentMatch.like();

                            ActionsToUsers(action: "like",user1: Global.userData.userId,user2: matchEngine.currentMatch.profile.id);
                            await Future.delayed(Duration(milliseconds: 1000));
                            CreateChat(false);
                          },child: Image.asset('assets/images/gamebtn.png',height: 50,width: 50,fit: BoxFit.fill,)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CreateChat(bool SuperLike){

    Firestore.instance.collection('inbox/messages/${Global.User.uid}').document(matchEngine.currentMatch.profile.id).setData({
      "uid":matchEngine.currentMatch.profile.id,
      "image":matchEngine.currentMatch.profile.dp,
      "name":matchEngine.currentMatch.profile.name,
      "msg":"It's a Match",
      'time': Timestamp.now(),
    });
    Firestore.instance.collection('inbox/messages/${matchEngine.currentMatch.profile.id}').document(Global.User.uid).setData({
      "uid":matchEngine.currentMatch.profile.id,
      "image":matchEngine.currentMatch.profile.dp,
      "name":matchEngine.currentMatch.profile.name,
      "msg":"It's a Match",
      'time': Timestamp.now(),
    });

    if(SuperLike){
      Global.OtherUserProfile = matchEngine.currentMatch.profile;
    //  Global.currentpageindex=2;
      if(!matchEngine.currentMatch.profile.disliked) {
        _showDialog();
      }
    }else
    {
      if(!matchEngine.currentMatch.profile.disliked) {
        _showDialog();
      }
    }

    //Navigator.of(context).pushReplacementNamed(SuperLike?'chat':'Messages');
    //Navigator.of(context).pushNamed('chat');
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AnchoredOverlay(
            showOverlay: true,
            overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor)
            { return BackdropFilter(
              filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      color:Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,

                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                              GestureDetector(onTap: (){
                                Navigator.of(context).pop();
                              },child: Icon(Icons.cancel,color: Global.orangepanda,size: 20,)),
                            ],),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset('assets/images/remote.png',width: Global.width*(Global.isweb?0.05:0.3),),
                            ),
                            CustomText(text:"New Connection!",color: Global.orangepanda,),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                      Global.OtherUserProfile = matchEngine.currentMatch.profile;

                                      if(Global.isweb){
                                        Navigator.of(context).pushReplacementNamed('webChattingPage');
                                      }else
                                      {
                                        Navigator.of(context).pushNamed('chat');
                                        Global.currentpageindex=2;
                                      }
                                      widget.callback();
                                      },
                                    child: CustomText(text:"Click here to chat now",color: Global.orangepanda,),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );},
            child: Center()
        );
      },
    );
  }

  Future ActionsToUsers({String action,String user1,String user2})
  {
    String URL = "";
    if(action=="like"){
      URL ="${Global.BaseURL}like";
    }else if(action == "dislike"){
      URL ="${Global.BaseURL}dislike";
    }else if(action == "superlike"){
      URL = "${Global.BaseURL}superlike";
    }
    http.post(URL,body:{
      "fromUserId":user1,
      "toUserId":user2,
    }).then((response){
      print(response.body.toString());
    });

  }



}
