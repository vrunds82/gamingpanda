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
    return Scaffold(
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
            Text("About You",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      new Container(height: 250,
          /*decoration: new BoxDecoration(

              borderRadius: new BorderRadius.all(Radius.circular(30))
          ),*/
          child: new Center(
            child: new TextField(maxLines: 8,
              decoration: InputDecoration(
                enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),

                  borderSide:  BorderSide(color: Colors.grey, width: 0.0),

                ),
                hintText: "Please write at what time you play, what are you looking for, what is your game style...",
              ),
            ),
          )
      ),],
           ),
         ),
       ),
    );
  }
}
