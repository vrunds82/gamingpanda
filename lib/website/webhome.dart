import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/CardsNew.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/Messages.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/SwipeUser.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:gamingpanda/website/webChatting.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class webHome extends StatefulWidget {
  @override
  _webHomeState createState() => _webHomeState();
}

class _webHomeState extends State<webHome> {


  PageController controller = new PageController(initialPage: Global.currentpageindex);
  UserData OtherUserProfile = new UserData();
  Profile UserProfile = new Profile();
  String games ="";
  bool loadingUserDeatils = false;

  void callback(){
    userDetails();
    setState(() {

    });

  }

  userDetails() async {
    UserProfile = null;
    loadingUserDeatils=true;
    setState(() {

    });

    print("Getting UserDetails of : ${Global.OtherUserProfile.id}");

   await http.post("${Global.BaseURL}profile/otherUser",
       body: {"UserId":Global.OtherUserProfile.id}).then((value) {



      OtherUserProfile = UserData.fromJson(jsonDecode(value.body));
    });

   print(jsonEncode(OtherUserProfile));


    if(OtherUserProfile.game1!=null && OtherUserProfile.game1!="" && Games.indexOf(OtherUserProfile.game1)!=-1 ){
      games = ShortName[Games.indexOf(OtherUserProfile.game1)];

    }
    if(OtherUserProfile.game1!=null && OtherUserProfile.game2!="" && Games.indexOf(OtherUserProfile.game2)!=-1){
      if(games==""){
        games = ShortName[Games.indexOf(OtherUserProfile.game2)];
      }else{
        games +=","+ ShortName[Games.indexOf(OtherUserProfile.game2)];
      }
    }

    List<String> pics = new List();
    if (OtherUserProfile.profilePicture != "" && OtherUserProfile.profilePicture != "null" && OtherUserProfile.profilePicture != null) {
      pics.add(OtherUserProfile.profilePicture);
    }
    if (OtherUserProfile.image1 != "" && OtherUserProfile.image1 != "null") {
      pics.add(OtherUserProfile.image1);
    }
    if (OtherUserProfile.image2 != "" && OtherUserProfile.image2 != "null") {
      pics.add(OtherUserProfile.image2);
    }
    if (OtherUserProfile.image3 != "" && OtherUserProfile.image3 != "null") {
      pics.add(OtherUserProfile.image3);
    }
    if (OtherUserProfile.image4 != "" && OtherUserProfile.image4 != "null") {
      pics.add(OtherUserProfile.image4);
    }
    if (OtherUserProfile.image5 != "" && OtherUserProfile.image5 != "null") {
      pics.add(OtherUserProfile.image5);
    }
    if (OtherUserProfile.image6 != "" && OtherUserProfile.image6 != "null") {
      pics.add(OtherUserProfile.image6);
    }

   UserProfile= Profile(bio: OtherUserProfile.aboutUs,
        name: OtherUserProfile.userName,
        photos: pics,
        id: OtherUserProfile.userId,
        dp: OtherUserProfile.profilePicture,
        age: (DateTime.now().year-OtherUserProfile.year).toString(),
        country: OtherUserProfile.country,
        games: games,
        gender: OtherUserProfile.gender
    );

    print(jsonEncode(UserProfile));

    loadingUserDeatils =false;
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
      Global.isSwitchedFT == true ? Colors.black : Colors.grey.withOpacity(0.2),
      body: Row(
        children: [
          Container(
            color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
            child: SizedBox(
              width: Global.webwidth*.25,
              child:  Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[Global.yellowpanda, Global.orangepanda])),
                    child: Row(
                      children: [
                        SizedBox(width: 25,),
                        Container(
                          height: 60,
                          width: 60,
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Colors.white
                         ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: new DecorationImage(

                                      fit: BoxFit.cover,
                                      image:Global.User.photoUrl==null||Global.User.photoUrl==""?AssetImage('assets/images/logo.png'): NetworkImage(Global.User.photoUrl),
                                    ))),
                          ),
                        ),
                        SizedBox(width: 10,),
                        CustomText(text:Global.userData.userName.length>15?Global.userData.userName.substring(0,15):Global.userData.userName,color: Colors.white,fontSize: 20,),
                        Spacer(),
                        GestureDetector(
                          onTap: (){


                            Navigator.of(context).pushReplacementNamed('webSettingPage');

                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('assets/images/settings.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                          Global.webCurrentPageIndex=0;
                          setState(() {

                          });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset('assets/images/remote.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 25,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomText(text: "Messages",fontSize: 25,color: Global.orangepanda,),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance.collection("inbox/messages/"+Global.User.uid).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting: return new Text('Loading...');
                            default:
                              print(snapshot.data.documents.toString());
                              return snapshot.data.documents.length!=0?
                              ListView(
                                children: snapshot.data.documents.map((DocumentSnapshot document) {
                                  return GestureDetector(onTap: (){
                                    Global.OtherUserProfile = Profile(
                                        name: document.data['name'],
                                        id: document.data['uid'],
                                        dp: document.data['image']
                                    );
                                   // Navigator.of(context).pushNamed('chat');
                                    Global.webCurrentPageIndex=1;
                                   //  Navigator.of(context).pushReplacementNamed('webChattingPage');
                                   userDetails();

                                  },child: myMessagesTile(documentSnapshot: document,));
                                }).toList(),
                              ):Center(child: CustomText(text:"No Messages "),);
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: <Widget>[
                        Switch(
                          inactiveThumbColor: Global.greypanda,
                          inactiveTrackColor: Global.blackpanda,
                          value: Global.isSwitchedFT,

                          onChanged: (bool value) async {
                            Global.isSwitchedFT = value;



                            SharedPreferences pref =
                            await SharedPreferences.getInstance();
                            await pref.setBool('theme', Global.isSwitchedFT);

                            setState(() {
                            });


                            //print(isSwitchedFT);
                          },
                          activeTrackColor: Global.darkBlue,
                          activeColor: Global.greypandaicon,
                        ),
                        CustomText(
                          text: "NIGHT MODE",
                          fontWeight: FontWeight.bold,

                        ),


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: myViews(),
            ),
          ),
        ],
      ),
    );
  }

  myViews(){
    switch (Global.webCurrentPageIndex){
      case 0:
        return SizedBox(
          width: Global.webwidth*.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: CardsNew(callback: this.callback,),
                ),
              )
            ],
          ),
        );

      case 1:
        return webChatting(games: games,loadingUserDeatils: loadingUserDeatils,UserProfile: UserProfile);
      case 2:
        return Messages();
    }
  }

}
