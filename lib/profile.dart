import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/Home.dart';
import 'package:gamingpanda/global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class profilepage extends StatefulWidget {
  Function callback;
  profilepage({this.callback});
  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {

  File croppedFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   if(Global.firstLogin){
     showWelcomeMessage();
     Global.firstLogin=false;
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
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
                          widget.callback();

                          //print(isSwitchedFT);
                        },
                        activeTrackColor: Global.darkBlue,
                        activeColor: Global.greypandaicon,
                      ),
                      CustomText(
                        text: "NIGHT MODE",
                        fontWeight: FontWeight.bold,

                      ),

                      Spacer(),
                      Container(
                          decoration: new BoxDecoration(
                              color: Global.orangepanda,
                              borderRadius:
                              new BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('settings');
                                },
                                child: Icon(
                                  Icons.settings,
                                  size: 30,
                                  color: Global.whitepanda,
                                )),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                GestureDetector(
                onTap: (){
           //   GetImage();
                },
                child:   Global.userData.profilePicture!="null" && Global.userData.profilePicture!="" && Global.userData.profilePicture!=null?Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(image: NetworkImage(Global.userData.profilePicture),fit: BoxFit.cover)
                  ),
                  width: 84,
                  height: 84,
                ):
                CircleAvatar(
                  radius: 42,
                  child: ClipOval(
                      child: Icon(
                        Icons.person,
                        size: 40,
                      )),
                ),
          ),
                SizedBox(
                  height: 15,
                ),
                CustomText(text: Global.userData.userName??"",fontSize: 18),
                CustomText(text: (DateTime.now().year-Global.userData.year).toString(),fontSize: 18,color: Global.orangepanda,  fontWeight: FontWeight.bold,),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/game.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  height: 5,
                ),
                (Global.userData.game1==""||Global.userData.game1==null)&&(Global.userData.game2==""||Global.userData.game2==null)?
                GestureDetector(
                  onTap: (){
                   /* Navigator.of(context).pushNamed('settings');*/
                  },
                  child: Column(
                    children: [
                      CustomText(
                        text:  "League of Legends",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      ),
                    /*  CustomText(
                        text:  "Click here to edit",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,

                      ),*/
                    ],
                  ),
                ):
                Column(
                  children: [
                    CustomText(
                      text:  Global.userData.game1==""||Global.userData.game1==null?"": Global.userData.game1,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),

                    CustomText(
                      text:   Global.userData.game2==""||Global.userData.game2==null?"": Global.userData.game2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),




            //Filter and EditProfile
            Column(
              children: [
                CustomButton(
                  backgroundColor: Global.orangepanda,
                  text: "FILTERS",
                  icon: Icon(MdiIcons.filter,color: Colors.white,),
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.of(context).pushNamed('filter');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  backgroundColor: Global.isSwitchedFT == true ? Global.whitepanda : Global.blackpanda,
                  text: "EDIT PROFILE",
                  icon: Icon(MdiIcons.pencil,color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,),
                  textColor: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
                  onPressed: (){
                   Navigator.of(context).pushNamed('editprofile');
                  },
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(""),
                CustomProfileRoundButton(onClick: (){
             /*     print(" Like Button Clicked");
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>BoostDialogBox(
                        icon: "assets/images/superLike.png",
                        iconColor: Global.SuperLikeBlue,
                        lowerText: "WITH SUPER LIKES SEND DIRECT MESSAGES TO ANYONE",
                        totalCoin: "5000",
                        upperText: "CONVERT PANDA COINS INTO SUPERLIKES",
                      )
                  );
                  print(" Like Button Clicked");*/

                },
                  img: "assets/images/superLike.png",
                  myText:  "${Global.superPlay<=0?0:Global.superPlay} Super Play",
                ),
                CustomProfileRoundButton(onClick: (){
                  print(" Like Button Clicked");
          /*        showDialog(
                      context: context,
                      builder: (BuildContext context) =>BoostDialogBox(
                        icon: "assets/images/boostIcon.png",
                        iconColor: Global.orangepanda,
                        lowerText: "USE BOOST AND BECOME TOP PROFILE FOR NEXT 60 MINUTES!",
                        totalCoin: "5000",
                        upperText: "CONVERT PANDA COINS INTO BOOST",
                      )
                  );
                  print(" Like Button Clicked");*/

                },
                  img: "assets/images/boostIcon.png",
                  myText: "BETA",
                ),
                CustomProfileRoundButton(onClick: (){
                 /* print(" Like Button Clicked");
                  Navigator.of(context).pushNamed('BuyCoinsNow');*/

                },
                  img: "assets/images/pandaCoins.png",
                  myText: "BETA",
                ),
                Text(""),
              ],
            ),

            GestureDetector(
              onTap: () async {
               /* print("Way to PRemium");
                Navigator.of(context).pushNamed("GetPremium");
*/

                const url = 'https://paypal.me/welovegamingpanda';
                if (await canLaunch(url)) {
                await launch(url);
                } else {
                throw 'Could not launch $url';
                }



              },
              child: Container(
                decoration: BoxDecoration(
                  color: Global.orangepanda,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                //color: Global.orangepanda,
                child: Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10.0,bottom: 5.0,top: 5.0),
                  child: Text("Donate & Reward",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<File> GetImage() async {
    String URL ="";


    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {

      croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          maxWidth: 500,
          maxHeight: 500,
          compressQuality: 70,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Image',
              toolbarColor: Global.blackpanda,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      );

      ProgressDialog(context);

      final StorageReference storageReferencem = FirebaseStorage()
          .ref()
          .child("Users/"+Global.User.email+ "/${DateTime.now().millisecondsSinceEpoch}");
      final StorageUploadTask uploadTaskm =
      storageReferencem.putFile(croppedFile);
      await uploadTaskm.onComplete;
      await storageReferencem.getDownloadURL().then((url) {
        URL=url;
      });

      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.photoUrl = URL;
     FirebaseUser u;
      await FirebaseAuth.instance.currentUser().then((User) {
        u = User;
      });
      await u.updateProfile(
          userUpdateInfo);
      await u.reload();
      await FirebaseAuth.instance
          .currentUser()
          .then((User) {
        Global.User = User;
      });


      await http.post("${Global.BaseURL}profile/profileImage",
          body:{
            "UserId": Global.User.uid,
            "ProfilePicture": URL,
          }
      ).then((response){
        print("There is no Response : "+response.body);
      });

      await GetUserDeatils();

        Navigator.of(context).pop();
    }


    setState(() {

    });
  }

  showWelcomeMessage() {

    Future.delayed(Duration(seconds: 2),(){
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: SizedBox(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Global.blackpanda,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Dear ${Global.userData.userName}, welcome to the Gaming Panda.\n\nHere you will find new friends for hanging out online and playing together.\n\nPlease be patient because we are new and just launched this beautiful app.",
                            style: TextStyle(color: Global.orangepanda),),
                        ),
                        FlatButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Close",style: TextStyle(color: Colors.white),))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });



  }

}
