import 'package:flutter/material.dart';
import 'package:gamingpanda/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profilepage extends StatefulWidget {
  @override
  _profilepageState createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomAppbar(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 42,
                    child: ClipOval(
                        child: Icon(
                      Icons.person,
                      size: 40,
                    )),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  CustomText(text: "Toni",fontSize: 18),
                  CustomText(text: "25",fontSize: 18,color: Global.orangepanda,  fontWeight: FontWeight.bold,),

                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/images/game.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  CustomText(
                    text:  "League of Legends, Gears of War,",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  CustomText(
                    text:  "Super Mario, Forza Moto...",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),


                  SizedBox(
                    height: 20,
                  ),

                  CustomButton(
                    backgroundColor: Global.orangepanda,
                    text: "FILTERS",
                    icon: Icon(MdiIcons.filter,color: Colors.white,),
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.of(context).pushNamed('filter');
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    backgroundColor: Global.isSwitchedFT == true ? Global.whitepanda : Global.blackpanda,
                    text: "EDIT PROFILE",
                    icon: Icon(MdiIcons.pencil,color: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,),
                    textColor: Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
                    onPressed: (){
                     Navigator.of(context).pushNamed('editprofile');
                    },
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: <Widget>[
                        Switch(
                          inactiveThumbColor: Global.greypanda,
                          inactiveTrackColor: Global.blackpanda,
                          value: Global.isSwitchedFT,

                          onChanged: (bool value) async {
                            Global.isSwitchedFT = value;

                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            await pref.setBool('theme', Global.isSwitchedFT);

                            setState(() {
                            });

                            //print(isSwitchedFT);
                          },
                          activeTrackColor: Global.darkBlue,
                          activeColor: Global.greypandaicon,
                        ),
                        CustomText(
                          text: "NIGHT MODE",
                          fontWeight: FontWeight.bold,

                        ),

                        Spacer(),
                        Container(
                            decoration: new BoxDecoration(
                                color: Global.orangepanda,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('settings');
                                  },
                                  child: Icon(
                                    Icons.settings,
                                    size: 30,
                                    color: Global.whitepanda,
                                  )),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
