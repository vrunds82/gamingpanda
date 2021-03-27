import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/global.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  File croppedFile,image;
  String URL ="";
  bool above18 = false;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  checkpassword(){

    if(password.text == confirmpassword.text)
    {
      Navigator.of(context).pushNamed('cardswipe');
    }
    else
      {
        Fluttertoast.showToast(
            msg: "Password not mached",
            //toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

  }

  final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
       body: Padding(
         padding: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1),
         child: Center(
           child: SingleChildScrollView(
             child: Column(

               children: <Widget>[
                SizedBox(height: 20,),
                 Text("REGISTRATION",style: TextStyle(
                     fontSize: 30,fontWeight: FontWeight.bold,color: Global.orangepanda
                 ),),
                 SizedBox(height: 15,),
                 GestureDetector(
                 onTap: () async {
                   image = await ImagePicker.pickImage(source: ImageSource.gallery);
                   if (image != null) {

                     croppedFile = await ImageCropper.cropImage(
                         sourcePath: image.path,
                         compressQuality: 70,
                         maxHeight: 300,
                         maxWidth: 300,
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






                   }
                   setState(() {

                   });
                 },
                   child: image!=null?Container(
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(100),

                         image: DecorationImage(image: FileImage(image),fit: BoxFit.cover)

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
                 ),



                 SizedBox(height: 10,),
                 CustomText(text: "Name",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: name,focusborder: true,),
                 SizedBox(height: 20,),
                 CustomText(text: "Email",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: email,focusborder: true,),
                 SizedBox(height: 20,),
                 CustomText(text: "Password",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: password,obsecuretext: true,focusborder: true,),
                 SizedBox(height:20,),
                 CustomText(text: "Confirm password",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: confirmpassword,obsecuretext: true,focusborder: true,),
                 SizedBox(height: 10,),
                 Row(children: [
                   SizedBox(width: 24,height: 24,child:
                   Checkbox(checkColor: Global.orangepanda,
                     activeColor: Global.darkgrey,
                     value: above18,
                     onChanged: (value){
                     above18 = value;
                     setState(() {

                     });
                   },),),
                   SizedBox(width: 10,),
                   CustomText(text:"I am above 18")
                 ],),
                 SizedBox(height: 10,),

                 Row(
                   children: <Widget>[
                     Expanded(
                         child: customraisedbutton(click: (){

                            if(!above18){
                              Fluttertoast.showToast(
                                  msg: "You must be above 18 to use this app.",
                                  //toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            } else if(name.text == "" )
                             {
                               Fluttertoast.showToast(
                                   msg: "Name filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );

                             }
                             else if (email.text == "")
                               Fluttertoast.showToast(
                                   msg: "Email filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email.text))
                               Fluttertoast.showToast(
                                   msg: "Invalid email address.",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             else if (password.text == "")
                               Fluttertoast.showToast(
                                   msg: "password filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             else if (confirmpassword.text.length<8)
                               Fluttertoast.showToast(
                                   msg: "For password minimum 8 characters required.",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );

                             else if (confirmpassword.text == "")
                               Fluttertoast.showToast(
                                   msg: "Confirmpassword filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             else if (password.text != confirmpassword.text)
                               Fluttertoast.showToast(
                                   msg: "Password not matched",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );

                             else{
                               SignUp();


                             }




                         },clr: Global.whitepanda,text: "REGISTER",bgclr: Global.orangepanda,)
                     ),
                   ],
                 ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(left: 15,right: 15),
                   child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       GestureDetector(onTap: (){
                         Navigator.of(context).pushNamed('registerp');
                       },
                         child: CustomText(text:"Already have Account?"),
                       ),
                      SizedBox(width: 5,),

                       GestureDetector(onTap: (){
                         Navigator.of(context).pushNamed('login');
                       },
                         child: CustomText(text:"Sign In",
                           fontSize: 18
                         ),
                       ),

                     ],
                   ),
                 ),
                 SizedBox(height: 20,),

                 GestureDetector(onTap: () async {
                   String url = "www.google.com";
                   if (await canLaunch(url)) {
                   await launch(url);
                   } else {
                   throw 'Could not launch $url';
                   }
                 },
                   child: Column(
                     children: [
                       CustomText(text:"By Registering you agree with our",color: Colors.grey,),
                       CustomText(text:"Terms and Conditions.",decoration: TextDecoration.underline,color: Colors.white,)
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
       ),
    );
  }


  SignupAPI(String Userid) async {

    print("Trying to Register");



    if(croppedFile!=null) {
      print("Uploading FUle");
      final StorageReference storageReferencem = FirebaseStorage()
          .ref()
          .child("Users/" +email.text + "/${DateTime
          .now()
          .millisecondsSinceEpoch}");
      final StorageUploadTask uploadTaskm = storageReferencem.putFile(croppedFile);
      await uploadTaskm.onComplete.catchError((onError){
        print(onError);
      });
      await storageReferencem.getDownloadURL().then((url) {
        URL = url;
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
    }else{
      print("Uploading");
    }

    print("Calling API");

    await http.post("${Global.BaseURL}register",
        body: {
          "UserId": Global.User.uid,
         "UserName": Global.User.displayName??name.text,
          "Email" : Global.User.email??email.text,
          "Token":Global.token??""
        }).then((response) async {
          print(response.statusCode);
    //  print("Response from Body : "+response.body.toString());
      await GetUserDeatils();
      Global.firstLogin=true;
      Navigator.of(context).pop();
   //   Navigator.of(context).pushReplacementNamed('cardswipe');
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  SignUp() async {

    ProgressDialog(context);

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password:password.text).
    then((result) async {
      if(result.user!=null) {
        Global.User=result.user;
        print("User Id : ${result.user.uid}");
        await SignupAPI(result.user.uid);
      }else{
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Something went Wrong");
      }

    }).catchError((onError){
      if(onError!=null && onError.message!=null) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: onError.message);
      }else
        {
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "Something went Wrong");
        }
    });
  }

}





