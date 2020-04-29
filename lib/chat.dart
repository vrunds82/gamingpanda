import 'package:flutter/material.dart';

import 'global.dart';

class chatscreen extends StatefulWidget {
  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: Column(
        children: <Widget>[
          CustomAppbar(),
          Expanded(
            child: ListView.builder(

                //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),

                itemBuilder: (BuildContext ctxt, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed('livechat');
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                  height: 70,
                                  width: 70,
                                  margin: EdgeInsets.only(
                                      left: 20, top: 15, bottom: 10),
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('assets/images/user.png'),
                                      ))),
                              Positioned(
                                right: 8,
                                bottom: 5,
                                child: Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      color: Global.orangepanda,
                                      size: 13,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                    text: "Ivana",
                                    fontSize: 15,
                                  ),
                                  Text(
                                    'Moze za pola sata',
                                    style: TextStyle(
                                        fontSize: 12, color: Global.greypandaicon),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
