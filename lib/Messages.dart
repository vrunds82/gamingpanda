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
    QuerySnapshot asdf = await Firestore.instance.collection("inbox/messages/"+Global.User.uid).getDocuments();
    print("Documentsdfa asdfasdf ${asdf.documents.length}");
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
                stream: Firestore.instance.collection("inbox/messages/"+Global.User.uid).orderBy('time',descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return new Text('Loading...');
                    default:
                      print(snapshot.data.documents.toString());
                      return snapshot.data.documents.length!=0?
                      ListView(
                        padding: EdgeInsets.all(0),
                        children: snapshot.data.documents.map((DocumentSnapshot document) {
                          return GestureDetector(onTap: (){
                            Global.OtherUserProfile = Profile(
                              name: document.data['name'],
                              id: document.data['uid'],
                              dp: document.data['image']
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



