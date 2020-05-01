import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamingpanda/global.dart';

class aboutu extends StatefulWidget {
  @override
  _aboutuState createState() => _aboutuState();
}

class _aboutuState extends State<aboutu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(automaticallyImplyLeading: false,
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
                 SizedBox(height: 20,),
                 Row(
                   children: <Widget>[
                     customcard(),
                     customcard(),
                     customcard(),
                   ],
                 ),
                 SizedBox(height: 20,),
                 Row(
                   children: <Widget>[
                     customcard(),
                     customcard(),
                     customcard(),
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
                 SizedBox(height: 10,),customgradientbuton(buttontext: "SAVE",)],
             ),
           ),
         ),
      ),
    );
  }
}
