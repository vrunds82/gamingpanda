import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/matches.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/Chat.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:gamingpanda/cardswipe.dart';
import 'package:gamingpanda/Messages.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/SwipeUser.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:gamingpanda/profile.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class webChatting extends StatefulWidget {
  @override
  _webChattingState createState() => _webChattingState();
}

class _webChattingState extends State<webChatting> {

  UserData OtherUserProfile = new UserData();
  String games ="";
  bool loadingUserDeatils = false;

  userDetails(){
    loadingUserDeatils=true;
    setState(() {

    });
    http.post("https://pandaweb20200510045646.azurewebsites.net/api/Panda/profile/otherUser",body: {"UserId":Global.OtherUserProfile.id}).then((value) {
      OtherUserProfile = UserData.fromJson(jsonDecode(value.body));
    });


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
    loadingUserDeatils =false;
    setState(() {

    });
  }


  void callback(){
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails();
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
                                      scale: 0.8,
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
                        Container(
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

                                    setState(() {
                                    });
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
              child: SizedBox(
                width: Global.webwidth*.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Chat(),
                    )
                  ],
                ),
              ),
            ),
          ),
          loadingUserDeatils?Center(child: CircularProgressIndicator(),): Container(
            color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
            child: SizedBox(
              width: Global.webwidth*.25,
              child:  Column(
                children: [
                  Container(
                    width: Global.webwidth*.25,
                    height: Global.webwidth*.25,
                   child: Global.OtherUserProfile.dp==null||Global.OtherUserProfile.dp==""?Padding(
                     padding: const EdgeInsets.all(25.0),
                     child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
                   ):Image.network(Global.OtherUserProfile.dp,fit: BoxFit.cover,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new Text(
                            "${OtherUserProfile.userName}  ${OtherUserProfile.year??0}",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize:18.0,
                            ),
                          ),
                          VerticalDivider(thickness: 2,color: Global.orangepanda,width: 10,),
                          Icon(OtherUserProfile.gender=="Male"?MdiIcons.genderMale:OtherUserProfile.gender!="Female"?MdiIcons.genderTransgender:MdiIcons.genderFemale,color: Colors.white,)
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          Image.asset("assets/images/gamegrey.png",height: 15,),
                          SizedBox(width: 10,),
                          new Text(
                           games,
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          //Flag('AD', height: 15, width: 20, fit: BoxFit.fill),
                          SizedBox(width: 10,),
                          new Text(
                            OtherUserProfile.country??"NA",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          new Text(
                            OtherUserProfile.aboutUs??"NA",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: customraisedbutton(
                                  click: (){
                                  },
                                  text: "DELETE",
                                  clr: Global.whitepanda,
                                  bgclr: Global.orangepanda,
                                )),
                          ],
                        ),
                        SizedBox(height: 25,),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: customraisedbutton(
                                  click: (){
                                  },
                                  text: "REPORT",
                                  clr: Global.whitepanda,
                                  bgclr: Global.blackpanda,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],

              ),
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
