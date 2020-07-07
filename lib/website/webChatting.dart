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
import 'package:fluttertoast/fluttertoast.dart';
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
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
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: customraisedbutton(
                                click: () async {

                                  ProgressDialog(context);
                                  print("inbox/messages/"+Global.User.uid+"/"+widget.UserProfile.id);
                                  await Firestore.instance.collection("inbox/messages/"+Global.User.uid).document(widget.UserProfile.id).delete().catchError((error){
                                    print(error);
                                  });
                                  Navigator.of(context).pop();
                                },
                                text: "DELETE",
                                clr: Global.whitepanda,
                                bgclr: Global.darkBlue,
                              )),
                          SizedBox(width: 25,),
                          Expanded(
                              child: customraisedbutton(
                                click: (){
                                  Fluttertoast.showToast(msg: "User Reported.");
                                },
                                text: "REPORT",
                                clr: Global.whitepanda,
                                bgclr: Global.darkBlue,
                              )),
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
  List<String> Images;
  UserImages({this.Images});

  @override
  _UserImagesState createState() => _UserImagesState();
}
class _UserImagesState extends State<UserImages> {
  PageController controller = new PageController(initialPage: 0);
  int pagenumber=0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(

            controller: controller,
            itemCount: widget.Images.length,

            onPageChanged: (number) async {
              print("PageChanged");
              print(number);
              pagenumber=number;
              setState(() {
              });

            },
            itemBuilder: (c, i) {
              return Container(
                width: Global.width,
                height: Global.height,
                child: Image.network(
                  widget.Images[i],
                  fit: BoxFit.cover,
                ),
              );
            }),
        widget.Images.length > 1
            ? Container(
          width: Global.width,
          height: Global.width,
          child: Center(
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      print(controller.page.toInt().toString());
                      controller.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn).whenComplete(() {
                        setState(() {

                          pagenumber=controller.page.toInt();

                        });

                      });

                      print("PageNUmber + $pagenumber");
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    )),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      print(controller.page.toInt().toString());
                      controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn).whenComplete(() {
                        pagenumber=controller.page.toInt();
                        setState(() {

                        });

                      });

                      print("PageNUmber + $pagenumber");

                    },
                    child: Container(   color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                          size: 50,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        )
            : SizedBox(),
        Positioned.fill(top: (Global.webwidth*.25)-30,child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 26,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.Images.length,
                          itemBuilder: (c,i){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: pagenumber==i?Colors.white:Colors.grey,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                height: 10,width: 10,
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),),
          ],
        ))
      ],
    );
  }



}
