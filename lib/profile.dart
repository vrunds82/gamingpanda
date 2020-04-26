

import 'package:flutter/material.dart';
import 'package:gamingpanda/global.dart';

class profilepage extends StatefulWidget {
  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar,

      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            SizedBox(height: 20,),
          CircleAvatar(
            radius: 42,
            child: ClipOval(
                child: Icon(Icons.person,size: 40,)
            ),
          ),
SizedBox(height: 20,),
            Text("Toni",style: TextStyle(
             color: blackpanda,fontSize: 18
            ),),
            Text("25",style: TextStyle(
                color: orangepanda,fontSize: 18,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 30,),

            Icon(Icons.games),
            SizedBox(height: 5,),
            Text("League of Legends, Gears of War,",style: TextStyle(
              fontSize: 16,fontWeight: FontWeight.bold
            ),),
            Text("Super Mario, Forza Moto...",style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 20,),

            Container(width: MediaQuery.of(context).size.width/2,
              child: RaisedButton.icon(
                  onPressed: (){  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  label: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 35),
                    child: Text('FILTERS',textAlign: TextAlign.start,
                      style: TextStyle(color: whitepanda,fontWeight: FontWeight.bold),),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                    child: Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            color: lightorangepanda),

                        child: Icon(Icons.edit, color:whitepanda,size: 20,)),
                  ),


                  color: orangepanda),
            ),

            SizedBox(height: 10,),

            Container(width: MediaQuery.of(context).size.width/2,
              child: RaisedButton.icon(
                  onPressed: (){  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('EDIT PROFILE',textAlign: TextAlign.center,
                      style: TextStyle(color: whitepanda,fontWeight: FontWeight.bold),),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                    child: Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            color: greypandaicon),

                        child: Icon(Icons.edit, color:lightorangepanda,size: 20,)),
                  ),


                  color: blackpanda),
            ),

            SizedBox(height: 30,),

Padding(
  padding: const EdgeInsets.only(left: 30,right: 30),
  child:   Row(children: <Widget>[

    Switch(

      value: Global.isSwitchedFT,

      onChanged: (bool value)

      {

        setState(() {



       /*   Global.isSwitchedFT = value;

          *//*saveSwitchState(value);//save thy value



          print('Saved state is $isSwitchedFT');*//*

          //switch works*/

        });



        //print(isSwitchedFT);

      },

      activeTrackColor: blackpanda,

      activeColor: greypandaicon,

    ),

    Text("NIGHT MODE",style: TextStyle(

      color: blackpanda

    ),),
    Spacer(),
    Container(
        decoration: new BoxDecoration(
            color: orangepanda,
            borderRadius: new BorderRadius.all(Radius.circular(30))
        ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.settings,size: 30,color: whitepanda,),
        ))

  ],),
)

        ],),
      ),
    );
  }
}
