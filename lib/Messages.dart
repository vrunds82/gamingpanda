import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'global.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  getDocuments() async {
    QuerySnapshot asdf = await FirebaseFirestore.instance.collection("inbox/messages/"+Global.firebaseUser.uid).get();
    print("Documentsdfa asdfasdf ${asdf.docs.length}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: Column(
        children: <Widget>[
        /*  CustomAppbar(),*/

          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomText(text: "Messages",fontSize: 25,color: Global.orangepanda,),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("inbox/messages/"+Global.firebaseUser.uid).orderBy('time',descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return new Text('Loading...');
                    default:
                      print(snapshot.data.docs.toString());
                      return snapshot.data.docs.length!=0?
                      ListView(
                        padding: EdgeInsets.all(0),
                        children: snapshot.data.docs.map((DocumentSnapshot document) {

                          Map<String,dynamic> data = document.data();

                          return GestureDetector(onTap: (){
                            Global.OtherUserProfile = Profile(
                              name: data['name'],
                              id:data['uid'],
                              dp: data['image'],
                              unmatched: data['unmatch']??false
                            );

                            print(jsonEncode(Global.OtherUserProfile));

                            Navigator.of(context).pushNamed('chat');

                          },child: myMessagesTile(documentSnapshot: document,));
                        }).toList(),
                      ):Center(child: GestureDetector(
                        onTap: (){

                          print(Global.userData.userId);

                          SendNotification(
                            body: "Testing Body",
                            title: "Testing Title",
                            userId: Global.userData.userId,
                            data: {"id": "asdf", "qwer": "wer"},
                            chat: "no",

                          );
                        }
                      ,child: CustomText(text:"No Messages ")),);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}



