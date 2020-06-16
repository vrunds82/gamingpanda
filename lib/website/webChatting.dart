import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
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

 // UserData OtherUserProfile = new UserData();
  Profile UserProfile = new Profile();
  String games ="";
  bool loadingUserDeatils = false;


  webChatting({this.UserProfile, this.games, this.loadingUserDeatils});

  @override
  _webChattingState createState() => _webChattingState();
}

class _webChattingState extends State<webChatting> {

  void callback(){
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacementNamed('webHome');
        return false;
      },
      child: Scaffold(
        backgroundColor:
        Global.isSwitchedFT == true ? Colors.black : Global.whitepanda,
        body: Row(
          children: [

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
            widget.loadingUserDeatils?SizedBox(width: Global.webwidth*.25,child: Center(child: CircularProgressIndicator(),)):
            Container(
              color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
              child: SizedBox(
                width: Global.webwidth*.25,
                child:  Column(
                  children: [
                   widget.UserProfile.photos.isNotEmpty?Container(    width: Global.webwidth*.25,
                       height: Global.webwidth*.25,child: UserImages(Images: widget.UserProfile.photos,)):Container(
                      width: Global.webwidth*.25,
                      height: Global.webwidth*.25,
                     child: Global.OtherUserProfile.dp==null||Global.OtherUserProfile.dp==""?Padding(
                       padding: const EdgeInsets.all(25.0),
                       child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,),
                     ):Image.network(Global.OtherUserProfile.dp,fit: BoxFit.cover,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              new CustomText(
                                text:"${widget.UserProfile.name}  ${widget.UserProfile.age??0}",
                                fontSize:18.0,
                                ),
                              VerticalDivider(thickness: 2,color: Global.orangepanda,width: 10,),
                              Icon(widget.UserProfile.gender=="Male"?MdiIcons.genderMale:widget.UserProfile.gender!="Female"?MdiIcons.genderTransgender:MdiIcons.genderFemale,color: Colors.white,)
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Image.asset("assets/images/gamegrey.png",height: 15,),
                              SizedBox(width: 10,),
                              new CustomText(
                               text:"Games : " +(widget.games??""),

                                  fontSize: 13,

                              ),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              //Flag('AD', height: 15, width: 20, fit: BoxFit.fill),
                              SizedBox(width: 10,),
                              new CustomText(
                                text:"Country : "+(widget.UserProfile.country??"NA"),
                                  fontSize: 13,

                              ),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              new CustomText(
                                text : "Description : "+(widget.UserProfile.bio??"NA"),

                                  fontSize: 15,

                              ),

                            ],
                          ),
                        ],
                      ),
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
                                    bgclr: Global.darkBlue,
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


  class UserImages extends StatefulWidget {

  List<String> Images ;
  UserImages({this.Images});

  @override
  _UserImagesState createState() => _UserImagesState();
}

class _UserImagesState extends State<UserImages> {

  PageController controller;


  @override
    Widget build(BuildContext context) {
      return Stack(
        children: [
          PageView.builder(
            controller: controller,
          itemCount: widget.Images.length,
              itemBuilder: (c,i){
            return Container(
              width: Global.webwidth*.25,
              height: Global.webwidth*.25,
              child: Image.network(widget.Images[i],fit: BoxFit.cover,),
            );
          }),
          widget.Images.length>1?Container(
            width: Global.webwidth*.25,
            height: Global.webwidth*.25,
            child: Center(child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(

                children: [
                  GestureDetector(onTap: (){
                   controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  },child: Icon(Icons.navigate_before,color: Colors.black45,size: 50,)),
                  Spacer(),
                  GestureDetector(onTap: (){
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  },child: Icon(Icons.navigate_next,color: Colors.black45,size: 50,))
                ],
              ),
            ),),
          ):SizedBox()
        ],
      );
    }
}


