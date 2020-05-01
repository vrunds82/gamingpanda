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
              padding: const EdgeInsets.fromLTRB(4,4,4,4),
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
            padding: EdgeInsets.only(bottom: 25,top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('assets/images/cancel.png',height: 45,width: 45,),

                Image.asset('assets/images/star.png',height: 45,width: 45,),

                Image.asset('assets/images/gamebtn.png',height: 45,width: 45,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
