import 'package:flutter/material.dart';

import 'global.dart';

class cardpage extends StatefulWidget {
  @override
  _cardpageState createState() => _cardpageState();
}

class _cardpageState extends State<cardpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.isSwitchedFT == true
          ? Global.blackpanda
          : Global.whitepanda,
      body: Column(

        children: <Widget>[
          CustomAppbar(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Image.asset('assets/images/user.png',


                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22,right: 22,top: 10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.cancel,size: 50,color: Global.greypanda,),
                      Spacer(),
                      Container(

                          decoration: BoxDecoration(color: Colors.blueAccent,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),


                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.star,color: Global.whitepanda,),
                          )),
                      Spacer(),
                      Container(

                          decoration: BoxDecoration(color: Global.greypandaicon,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),


                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/game.png',height: 30,width: 30,)
                          )),

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
