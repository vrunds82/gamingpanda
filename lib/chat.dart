import 'package:flutter/material.dart';

import 'global.dart';

class chatscreen extends StatefulWidget {
  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar,

body:   ListView.builder(
  //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),

    itemBuilder: (BuildContext ctxt, int index) {
      return  Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(height: 70,width: 70,margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image:AssetImage('assets/images/user.png'),
                          )
                      )
                  ),
                  Positioned(
                    right: 8,bottom: 8,
                    child: Card(elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(




                            child: Icon(Icons.brightness_1,color: orangepanda,size: 12,)),
                      ),
                    ),
                  ),
                ],
              ),





              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:30),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Ivana',style: TextStyle(fontSize: 15),textAlign: TextAlign.left,),
                      Text('Moze za pola sata',style: TextStyle(fontSize: 12,color: greypandaicon),textAlign: TextAlign.left,),

                    ],
                  ),
                ),
              ),

            ], ),



        ],
      );
    }
),
    );
  }
}
