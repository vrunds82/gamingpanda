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
    Global.dates.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:Global.isweb? Colors.transparent: Global.isSwitchedFT == true ?  Global.blackpanda: Global.whitepanda,

   /*   appBar: AppBar(
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
      ),*/
      body : Column(
        children: <Widget>[
          Global.isweb? Container(
        height: 80,
        color: Global.isSwitchedFT == true ? Global.blackpanda: Global.whitepanda,
          child:
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Row(
                    children: [
                     /* SizedBox(width: 20,),
                      GestureDetector(
                      onTap: () {
                        Global.webCurrentPageIndex = 0;
                        setState(() {
                        });
                      }
    ,child: Image.asset(Global.isSwitchedFT?"assets/images/backDark.png":"assets/images/backLight.png",height: 50,)),*/
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,

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
                                fontSize: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                  /*    Opacity(opacity: 0,child: Image.asset(Global.isSwitchedFT?"assets/images/backDark.png":"assets/images/backLight.png",height: 40,)),*/
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
                      ),
                      SizedBox(width: 20,),
                    ],
                  ),
                ),
              ),
              Container(color:  Global.isSwitchedFT == true ? Global.blackpanda : Colors.grey.withOpacity(0.2),height: 2,)
            ],
          ),
        ):
          AppBar(

            backgroundColor:
            Global.isweb?Colors.transparent:  Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,

            leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back,color:Global.isSwitchedFT == true ? Global.whitepanda : Global.blackpanda ,),
              ),
            ),

            title: Row(

              children: <Widget>[
                GestureDetector(
                  onTap:(){
                    Navigator.of(context).pushNamed('otherUserDetails');
                  },
                  child: Container(
                      height: 30,
                      width: 30,
                      margin: EdgeInsets.only(left: 00, top: 15, bottom: 10),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image:  Global.OtherUserProfile.dp==null|| Global.OtherUserProfile.dp==""?AssetImage('assets/images/user.png'):NetworkImage( Global.OtherUserProfile.dp),
                          ))),
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: Global.OtherUserProfile.name.length>12?Global.OtherUserProfile.name.substring(0,12):Global.OtherUserProfile.name,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            centerTitle: true,
            actions: <Widget>[

              PopupMenuButton(
            icon: Icon(Icons.more_vert,color:Global.isSwitchedFT == true ? Global.whitepanda : Global.blackpanda ,),


                onSelected: (index){
                  print("Clicked");
                  Navigator.of(context).pushNamed('otherUserDetails');
                },

                color:Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,

                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 0,
                      child: CustomText(text:"Show Profile",),
                    ),
                  /*  PopupMenuItem(
                      child: CustomText(text:"Delete Conversation"),),*/
                  ];
                },
              )
            ],
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Chat/Chatting/"+Global.userData.userId+"-"+Global.OtherUserProfile.id)
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
                onSubmitted: (va){
                  sendMessage();
                  textEditingController.text="";
                  setState(() {
                  });
                },
                style: TextStyle(color: Global.orangepanda),
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: Global.orangepanda, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                    BorderSide(color: Global.orangepanda/*Global.isSwitchedFT == false ? Global.darkBlue : Global.greypanda*/, width: 0.0),
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
                    border: Border.all(color: Global.orangepanda/*Colors.black*/,style: BorderStyle.solid,width: 2),
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
                   //   Fluttertoast.showToast(msg: "Clicked");
                    },
                    splashColor: Global.orangepanda,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.send,color:Global.orangepanda/* Global.isSwitchedFT?Global.orangepanda:Global.blackpanda*/,),
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


  sendMessage() async {
    Firestore.instance
        .collection("Chat/Chatting/"+Global.userData.userId+"-"+Global.OtherUserProfile.id)
        .document()
        .setData({
      'msg': textEditingController.text.toString(),
      'time': Timestamp.now(),
      'sendby': Global.userData.email,
      "uid":Global.userData.userId,
    });

    Firestore.instance
        .collection("Chat/Chatting/"+Global.OtherUserProfile.id+"-"+Global.userData.userId)
        .document()
        .setData({
      'msg': textEditingController.text.toString(),
      'time': Timestamp.now(),
      'sendby': Global.userData.email,
      "uid":Global.userData.userId,
    });

    Firestore.instance.collection('inbox/messages/${Global.userData.userId}').document(Global.OtherUserProfile.id).updateData({
      "uid":Global.OtherUserProfile.id,
      "image":Global.OtherUserProfile.dp,
      "name":Global.OtherUserProfile.name,
      "msg":textEditingController.text.toString(),
    });

    Firestore.instance.collection('inbox/messages/${Global.OtherUserProfile.id}').document(Global.userData.userId).updateData({
      "uid":Global.userData.userId,
      "image":Global.userData.profilePicture,
      "name":Global.userData.userName,
      "msg":textEditingController.text.toString(),
    });



    await SendNotification(
        chat: 'yes',
        body:textEditingController.text.toString(),
    title: Global.userData.userName,
    data: {"id": "asdf", "qwer": "wer"},
    userId: Global.User.uid);
  }



}


Widget Mychatbox(context, DocumentSnapshot document) {


  Timestamp  timestamp= document['time'];
  DateTime time = timestamp.toDate();
  String ampm = (time.hour/12).toInt()==0?"am":"pm";
  String hour = /*(time.hour%12).toInt().toString().length==1?"0"+(time.hour%12).toInt().toString():*/(time.hour%12).toInt().toString();
  String min = (time.minute).toInt().toString().length==1?"0"+(time.minute).toInt().toString():(time.minute).toInt().toString();
  String date = hour +":"+min+" "+ampm;
  String day = time.day.toString().length==0?"0"+ time.day.toString(): time.day.toString();
  String month = time.month.toString().length==0?"0"+ time.month.toString(): time.month.toString();
  String ChatDay = "$day/$month/${time.year}";

  bool ispresent =true;


if(!Global.dates.contains(ChatDay)){
  ispresent=false;
  Global.dates.add(ChatDay);
}

  /*String date =
  ((timestamp.toDate().hour%12).toString()).length==1?"0"+((timestamp.toDate().hour%12).toString()):((timestamp.toDate().hour%12).toString() )+":"+
      (timestamp.toDate().minute.toString().length==1?"0"+timestamp.toDate().minute.toString():timestamp.toDate().minute.toString())+" "+
      ((timestamp.toDate().hour%12)==1? "am  ":"pm  ")+
      timestamp.toDate().day.toString()+"/"+
      timestamp.toDate().month.toString()+"/"+
      timestamp.toDate().year.toString();*/

  print("Date : "+date);

  return Column(
    children: [
      /*!ispresent?Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20,20,20,20),
            child: Text(ChatDay,style: TextStyle(color: Global.orangepanda,fontSize: 20),),
          )
        ],
      ):SizedBox(),*/
      Row(
        mainAxisAlignment: document['uid'].toString() == Global.userData.userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          document['uid'].toString() != Global.userData.userId ?Container(
              height: 30,
              width: 30,
              margin:
              EdgeInsets.only(left: 20, top: 15, bottom: 10),
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: Global.OtherUserProfile.dp==null?AssetImage('assets/images/logo.png'):NetworkImage(Global.OtherUserProfile.dp),
                  ))):SizedBox(),
          Expanded(
            child: Column(
              crossAxisAlignment: document['uid'].toString() == Global.userData.userId
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape:document['uid'].toString() != Global.userData.userId ?  RoundedRectangleBorder(
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
                  color: document['uid'].toString() != Global.userData.userId
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
                  mainAxisAlignment: document['uid'].toString() == Global.User.uid
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,20,0),
                      child: Text(date.toString()+"  "+ChatDay,style: TextStyle(color: Global.isSwitchedFT == true ?  Global.whitepanda: Global.greypanda,fontSize: 10),),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ],
  );
}
