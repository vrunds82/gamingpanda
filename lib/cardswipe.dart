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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3,1,3,0),
              child: ClipRRect(borderRadius: BorderRadius.all(
                Radius.circular(20)
              ),
                child: Image.asset('assets/images/user.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60,right: 60,bottom: 20,top: 10),
            child: Row(
              children: <Widget>[
                Icon(Icons.cancel,size: 50,color: Global.greypanda,),
                Spacer(),
                Card(color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.star,color: Global.whitepanda,size: 20,),
                  ),
                ),
                Spacer(),
                Card(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/game.png',height: 32,width: 32,)
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
