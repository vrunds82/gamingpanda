import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/Home.dart';
import 'package:gamingpanda/global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilepage extends StatefulWidget {

  Function callback;

  profilepage({this.callback});

  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {

  File croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        /*    CustomAppbar(),*/
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Global.userData.profilePicture!="" && Global.userData.profilePicture!=null?Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),

                      image: DecorationImage(image: NetworkImage(Global.User.photoUrl))

                    ),
                    width: 84,
                    height: 84,
                  ):CircleAvatar(
                    radius: 42,
                    child: ClipOval(
                        child: Icon(
                      Icons.person,
                      size: 40,
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  CustomText(text: Global.userData.userName,fontSize: 18),
                  CustomText(text: (DateTime.now().year-Global.userData.year).toString(),fontSize: 18,color: Global.orangepanda,  fontWeight: FontWeight.bold,),

                  SizedBox(
                    height: 30,
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
                      Navigator.of(context).pushNamed('settings');
                    },
                    child: Column(
                      children: [
                        CustomText(
                          text:  "No Games Selected",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),
                        CustomText(
                          text:  "Click here to edit",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,

                        ),
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



                  SizedBox(
                    height: 20,
                  ),

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

                  SizedBox(
                    height: 30,
                  ),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<File> GetImage(int index) async {
    String URL ="";


    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {

      croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
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
        Navigator.of(context).pop();



    }


    setState(() {

    });
  }

}
