import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class aboutu extends StatefulWidget {
  @override
  _aboutuState createState() => _aboutuState();
}

class _aboutuState extends State<aboutu> {

  List<File> myImagesFiles= new List();
  List<String> myImagesURL = new List();
  TextEditingController AboutUsController = new TextEditingController(text: Global.userData.aboutUs);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myImagesFiles = [null,null,null,null,null,null];
    myImagesURL = [null,null,null,null,null,null];
    myImagesURL[0] = Global.userData.image1==""?null:Global.userData.image1;
    myImagesURL[1] = Global.userData.image2==""?null:Global.userData.image2;
    myImagesURL[2] = Global.userData.image3==""?null:Global.userData.image3;
    myImagesURL[3] = Global.userData.image4==""?null:Global.userData.image4;
    myImagesURL[4] = Global.userData.image5==""?null:Global.userData.image5;
    myImagesURL[5] = Global.userData.image6==""?null:Global.userData.image6;
    print(myImagesURL.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Global.yellowpanda, Global.orangepanda])),
        ),
        backgroundColor: Global.whitepanda,
        title: Row(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: Global.whitepanda,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.keyboard_backspace,
                      color: Global.orangepanda,
                    ),
                  )),
            ),
            SizedBox(width: 10,),
            Row(
              children: <Widget>[
                Text(
                  "Edit profile",
                  style: TextStyle(
                      color: Global.blackpanda,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.more_vert,
              color: Global.orangepanda,
            ),
          ],
        ),
      ),
        backgroundColor: Global.isSwitchedFT == true
            ? Global.blackpanda
            : Global.whitepanda,
         body: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Column(
               children: <Widget>[

                 Row(
                   children: <Widget>[
                     customcard(onclick: () async {
                       print("asdasdfadf");
                       GetImage(0);
                     },
                     file: myImagesFiles[0],
                       ImageURL: myImagesURL[0],
                     ),
                     customcard(onclick: () async {
                       print("asdasdfadf");
                       GetImage(1);
                     },
                       file: myImagesFiles[1],
                       ImageURL: myImagesURL[1],
                     ),
                     customcard(onclick: () async {
                       print("asdasdfadf");
                       GetImage(2);
                     },
                       file: myImagesFiles[2],
                       ImageURL: myImagesURL[2],
                     ),

                   ],
                 ),
                 SizedBox(height: 20,),
                 Row(
                   children: <Widget>[
                     customcard(onclick: () async {
                       print("asdasdfadf");
                       GetImage(3);
                     },
                       file: myImagesFiles[3],
                       ImageURL: myImagesURL[3],
                     ),customcard(onclick: () async {
                       print("asdasdfadf");
                       GetImage(4);
                     },
                       file: myImagesFiles[4],
                       ImageURL: myImagesURL[4],
                     ),customcard(onclick: () async {
                       print("asdasdfadf");
                       GetImage(5);
                     },
                       file: myImagesFiles[5],
                       ImageURL: myImagesURL[5],
                     ),

                   ],
                 ),
                 SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomText(text: "About You",fontSize: 22,
                fontWeight: FontWeight.bold,),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
          child: new Container(
              /*decoration: new BoxDecoration(

                  borderRadius: new BorderRadius.all(Radius.circular(30))
              ),*/
              child: new Center(
                child: new TextField(
                  controller: AboutUsController,
                  //minLines: 10,
                  maxLines: 10,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Please write at what time you play, what are you looking for, what is your game style...",
      hintStyle: TextStyle(color: Global.isSwitchedFT == true
      ? Global.whitepanda
      : Global.blackpanda,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Global.greypandaicon),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color:Global.orangepanda),
                    ),
                  ),
                ),
              ),

          ),
        ),
                 SizedBox(height: 10,),customgradientbuton(buttontext: "SAVE",onClicked: (){onSubmit();},
                 )],
             ),
           ),
         ),
      ),
    );
  }

  onSubmit()
  async {

    ProgressDialog(context);

    print(myImagesURL);
    print(AboutUsController.text);

    await http.post("https://pandaweb20200510045646.azurewebsites.net/api/Panda/image",body: {
      "UserId":Global.User.uid,
      "image1":myImagesURL[0]??"null",
      "image2":myImagesURL[1]??"null",
      "image3":myImagesURL[2]??"null",
      "image4":myImagesURL[3]??"null",
      "image5":myImagesURL[4]??"null",
      "image6":myImagesURL[5]??"null",
      "AboutUs":AboutUsController.text.toString()
    }).then((value){
      print(value.body);
    });
    GetUserDeatils();
    setState(() {

    });
    Navigator.of(context).pop();
    Fluttertoast.showToast(msg: "Details Updated");
  }



  Future<File> GetImage(int index) async {
    String URL ="";
    File croppedFile;

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


        myImagesURL[index]=URL;
        myImagesFiles[index]=croppedFile;


        print(myImagesURL);

      Navigator.of(context).pop();




    }


    setState(() {

    });
  }


}
