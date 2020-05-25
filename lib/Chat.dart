import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'global.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = new TextEditingController();
  FirebaseUser firebaseUser;

  ChkFirebaseUSer() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        FirebaseAuth.instance.signInAnonymously().then((user) {
          firebaseUser = user.user;
        });
      } else {
        firebaseUser = user;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChkFirebaseUSer();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
      Global.isweb?Colors.transparent:  Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,
        brightness:
        Global.isSwitchedFT == false ? Brightness.light : Brightness.dark,
        title: Row(

          children: <Widget>[
            Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image:  Global.OtherUserProfile.dp==null|| Global.OtherUserProfile.dp==""?AssetImage('assets/images/user.png'):NetworkImage( Global.OtherUserProfile.dp),
                    ))),
            SizedBox(
              width: 15,
            ),
            CustomText(
              text: Global.OtherUserProfile.name.length>12?Global.OtherUserProfile.name.substring(0,12):Global.OtherUserProfile.name,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),

            // For Adjusting Space

            SizedBox(
              width: 5,
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[

          PopupMenuButton(
            color:  Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: CustomText(text:"Show Profile"),
                ),
                PopupMenuItem(
                  child: CustomText(text:"Delete Conversation"),),
              ];
            },
          )
        ],
      ),
      body : Column(
        children: <Widget>[
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Chat/Chatting/"+Global.User.uid+"-"+Global.OtherUserProfile.id)
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        reverse: true,
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Mychatbox(context, document);
                        }).toList(),
                      );
                  }
                },
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: <Widget>[
                           SizedBox(width: 10,),
              Expanded(child:
              TextField(
                style: TextStyle(color: Global.orangepanda),
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: Global.greypandaicon, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                    BorderSide(color: Global.isSwitchedFT == false ? Global.darkBlue : Global.greypanda, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.only(
                      left: 8, right: 8, top: 0, bottom: 0),
                  fillColor: Global.isSwitchedFT == true ? Global.darkBlue : Global.greypanda.withOpacity(0.2),
                ),
              )
              /*TextField(
                controller: textEditingController,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2),
                        borderRadius:BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2),
                        borderRadius:BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 10),
                        borderRadius:BorderRadius.all(Radius.circular(10))),
                    hintText: "Message"),

              )*/,
              ),
              SizedBox(width: 10,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,style: BorderStyle.solid,width: 2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: (){
                      sendMessage();
                      textEditingController.text="";
                      setState(() {

                      });
                      Fluttertoast.showToast(msg: "Clicked");
                    },
                    splashColor: Global.orangepanda,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ],),
          )
        ],

      ),
    );
  }


  sendMessage(){
    Firestore.instance
        .collection("Chat/Chatting/"+Global.User.uid+"-"+Global.OtherUserProfile.id)
        .document()
        .setData({
      'msg': textEditingController.text.toString(),
      'time': Timestamp.now(),
      'uid': Global.User.email
    });

    Firestore.instance
        .collection("Chat/Chatting/"+Global.OtherUserProfile.id+"-"+Global.User.uid)
        .document()
        .setData({
      'msg': textEditingController.text.toString(),
      'time': Timestamp.now(),
      'uid': Global.User.email
    });

    Firestore.instance.collection('inbox/messages/${Global.User.uid}').document(Global.OtherUserProfile.id).setData({
      "uid":Global.OtherUserProfile.id,
      "image":Global.OtherUserProfile.dp,
      "name":Global.OtherUserProfile.name,
      "msg":"It's a Match",
    });

    Firestore.instance.collection('inbox/messages/${Global.OtherUserProfile.id}').document(Global.User.uid).setData({
      "uid":Global.OtherUserProfile.id,
      "image":Global.userData.profilePicture,
      "name":Global.userData.userName,
      "msg":"It's a Match",
    });


  }






}


Widget Mychatbox(context, DocumentSnapshot document) {

  Timestamp  timestamp= document['time'];
  var date = (timestamp.toDate().hour%12).toString().length==1?"0"+(timestamp.toDate().hour%12).toString():(timestamp.toDate().hour%12).toString() +":"+
      (timestamp.toDate().minute.toString().length==1?"0"+timestamp.toDate().minute.toString():timestamp.toDate().minute.toString())+" "+
      ((timestamp.toDate().hour%12)==1? "am  ":"pm  ")+
      timestamp.toDate().day.toString()+"/"+
      timestamp.toDate().month.toString()+"/"+
      timestamp.toDate().year.toString();
  return Row(
    mainAxisAlignment: document['uid'].toString() == Global.User.email
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
    children: <Widget>[
      document['uid'].toString() != Global.User.email ?Container(
          height: 30,
          width: 30,
          margin:
          EdgeInsets.only(left: 20, top: 15, bottom: 10),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/user.png'),
              ))):SizedBox(),
      Column(
        crossAxisAlignment: document['uid'].toString() == Global.User.email
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            shape:document['uid'].toString() != Global.User.email ?  RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(24)),

              /* side: BorderSide(width: 1, color: Colors.green)*/
            ):
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(18),
                  topLeft: Radius.circular(18)),

              /* side: BorderSide(width: 1, color: Colors.green)*/
            ),
            color: document['uid'].toString() != Global.User.email
                ? Global.greypanda
                : Global.orangepanda,
            child: Container(
              child: Padding(
                padding:  EdgeInsets.all(document['type']==null||document['type']=='text'?8.0:2),
                child: ConstrainedBox(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*.7),child: Padding(
                  padding:  EdgeInsets.all(document['type']==null||document['type']=='text'?4.0:2),
                  child:document['type']==null||document['type']=='text'?
                  Text(document['msg'].toString(),style: TextStyle(color:Colors.white,))
                      :GestureDetector(onTap: (){
                    // GlobalData.ZoomImage=document['msg'].toString();
                    Navigator.of(context).pushNamed('zoomImage');
                  },child: Image.network(document['msg'].toString())),
                )),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: document['uid'].toString() != Global.User.uid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Text(date.toString(),style: TextStyle(color: Colors.white,fontSize: 10),),
              ),
            ],
          )
        ],
      )
    ],
  );
}
