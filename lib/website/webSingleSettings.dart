import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:gamingpanda/global.dart';

import 'package:http/http.dart' as http;

class webSingleSettingPage extends StatefulWidget {
  @override
  _webSingleSettingPageState createState() => _webSingleSettingPageState();
}

class _webSingleSettingPageState extends State<webSingleSettingPage> {



  TextEditingController username = TextEditingController(text: Global.userData.userName);



 static List<String> Monthlist = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> daylist = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30"

  ];

  List<String> listitems = ['A', 'B', 'C', 'D'];
  List<String> yearlist = [

    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006",
    "2007",
    "2008",
    "2009",
    "2010",
  ];

  String day = Global.userData.day.toString();
  String month = Monthlist[Global.userData.month>10?11:Global.userData.month+1];
  String year = Global.userData.year.toString();
  String _currentSelectedItemserver = Global.userData.server;
  String _currentSelectedItemrank = Global.userData.rank;
  String _currentSelectedItemcountry = Global.userData.country;
  String _currentSelectedItemgame = Global.userData.game1;
  String _currentSelectedItemgame2 = Global.userData.game2;


// Declare this variable
  int selectedRadio;

  setyears(){
    yearlist.clear();

    int currentYear = DateTime.now().year;
    for(int i =0;i<60;i++)
      {
        yearlist.add((currentYear-i).toString());
      }
  }

  @override
  void initState() {
    super.initState();
    setyears();
    selectedRadio = Global.userData.gender==null||Global.userData.gender==""?0:gender.indexOf(Global.userData.gender);
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _radioValue1;
    var _handleRadioValueChange1;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
        Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
        appBar: AppBar(automaticallyImplyLeading: false,
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

                  if(Global.isweb){
                    Navigator.of(context).pushReplacementNamed('webHome');
                  }else {
                    Navigator.of(context).pop();
                  }
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
              Spacer(),
              Row(
                children: <Widget>[
                  Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      decoration: new BoxDecoration(
                          border: Border.all(color: Global.whitepanda, width: 2),
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/user.png'),
                          ))),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Toni",
                    style: TextStyle(
                        color: Global.blackpanda,
                        fontSize: 14,
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
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.cancel, color: Colors.transparent),
                  ),
                  Expanded(
                      flex: 8,
                      child: Customtextfield(
                        obsecuretext: false,
                        controllername: username,
                        hinttext: "Username...",
                        align: false,
                        focusborder: false,
                      )),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.cancel, color: Colors.transparent),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //dropdown1
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.cancel, color: Colors.transparent),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Global.greypandaicon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Theme(data: Theme.of(context).copyWith(
                              canvasColor: Global.isSwitchedFT == true
                                  ? Global.blackpanda
                                  : Global.whitepanda,
                            ),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: CustomText(
                                    text:"Game 1",
                                    fontSize: 12,
                                  ),
                                ),
                                underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Global.orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: Games.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomText(text:val),
                                    ),
                                  );
                                }).toList(),
                                value: _currentSelectedItemgame,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSelectedItemgame = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        _currentSelectedItemgame=null;
                        setState(() {

                        });
                      },
                      child:_currentSelectedItemgame==null?SizedBox(): Icon(
                        Icons.cancel,
                        color: Global.greypandaicon,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
//dropdown2
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.cancel, color: Colors.transparent),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Global.greypandaicon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Theme(data: Theme.of(context).copyWith(
                              canvasColor: Global.isSwitchedFT == true
                                  ? Global.blackpanda
                                  : Global.whitepanda,
                            ),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: CustomText(
                                    text:
                                    "Game 2",
                                    fontSize: 12,
                                  ),
                                ),
                                underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Global.orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: Games.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomText(
                                        text:val,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                value: _currentSelectedItemgame2,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSelectedItemgame2 = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(onTap:(){
                      _currentSelectedItemgame2=null;
                      setState(() {

                      });
                    },child: _currentSelectedItemgame2==null?SizedBox():Icon(Icons.cancel, color: Global.greypandaicon)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //drowndown3

              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(onTap: (){

                    },child: Icon(Icons.cancel, color: Colors.transparent)),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Global.greypandaicon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Theme(data: Theme.of(context).copyWith(
                              canvasColor: Global.isSwitchedFT == true
                                  ? Global.blackpanda
                                  : Global.whitepanda,
                            ),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: CustomText(
                                    text:"Server",
                                    fontSize: 12,
                                  ),
                                ),
                                underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Global.orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: Server.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomText(
                                        text:val,
                                        fontSize: 12),

                                    ),
                                  );
                                }).toList(),
                                value: _currentSelectedItemserver,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSelectedItemserver = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(onTap: (){
                      _currentSelectedItemserver=null;
                      setState(() {

                      });
                    },child:_currentSelectedItemserver==null?SizedBox(): Icon(Icons.cancel, color: Global.greypandaicon)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //dropdown4
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.cancel, color: Colors.transparent),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Global.greypandaicon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Theme(data: Theme.of(context).copyWith(
                              canvasColor: Global.isSwitchedFT == true
                                  ? Global.blackpanda
                                  : Global.whitepanda,
                            ),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: CustomText(
                                    text:"Rank",
                                    fontSize: 12,
                                  ),
                                ),
                                underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Global.orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: Rank.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomText(text:val,
                                          fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                value: _currentSelectedItemrank,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSelectedItemrank = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(onTap: (){
                      _currentSelectedItemrank=null;
                      setState(() {

                      });
                    },child:_currentSelectedItemrank==null?SizedBox(): Icon(Icons.cancel, color: Global.greypandaicon)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //dropdown5
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.cancel, color: Colors.transparent),
                  ),
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Global.greypandaicon,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Theme(data: Theme.of(context).copyWith(
                              canvasColor: Global.isSwitchedFT == true
                                  ? Global.blackpanda
                                  : Global.whitepanda,
                            ),
                              child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: CustomText(
                                    text:"Country",
                                    fontSize: 12,
                                  ),
                                ),
                                underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Global.orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: countryList.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomText(text:val,
                                          fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                value: _currentSelectedItemcountry,
                                onChanged: (value) {
                                  setState(() {
                                    _currentSelectedItemcountry = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(onTap: (){
                      _currentSelectedItemcountry=null;
                      setState(() {

                      });
                    },child: _currentSelectedItemcountry==null?SizedBox():Icon(Icons.cancel, color: Global.greypandaicon)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              //DOB
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text:"Date of Birth",
                                fontSize: 12),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 76,
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Global.greypandaicon,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Theme(data: Theme.of(context).copyWith(
                                        canvasColor: Global.isSwitchedFT == true
                                            ? Global.blackpanda
                                            : Global.whitepanda,
                                      ),
                                        child: DropdownButton(
                                          hint: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 13),
                                            child: CustomText(
                                              text:"Day",
                                              fontSize: 12),

                                          ),
                                          underline: SizedBox(),
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Global.orangepanda,
                                              size: 20.09,
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: daylist.map((val) {
                                            return DropdownMenuItem(
                                              value: val,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: CustomText(
                                                  text:val,
                                                  fontSize: 10),

                                              ),
                                            );
                                          }).toList(),
                                          value: day,
                                          onChanged: (value) {
                                            setState(() {
                                              day = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Global.greypandaicon,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Theme(data: Theme.of(context).copyWith(
                                      canvasColor: Global.isSwitchedFT == true
                                          ? Global.blackpanda
                                          : Global.whitepanda,
                                    ),
                                      child: DropdownButton(
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18),
                                          child: CustomText(
                                            text:"Month",
                                            fontSize: 12,
                                          ),
                                        ),
                                        underline: SizedBox(),
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Global.orangepanda,
                                            size: 20.09,
                                          ),
                                        ),
                                        isExpanded: true,
                                        items: Monthlist.map((val) {
                                          return DropdownMenuItem(
                                            value: val,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: CustomText(
                                                text:val,
                                                fontSize: 10,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        value: month,
                                        onChanged: (value) {
                                          setState(() {
                                            month = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 83,
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Global.greypandaicon,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Theme(data: Theme.of(context).copyWith(
                                        canvasColor: Global.isSwitchedFT == true
                                            ? Global.blackpanda
                                            : Global.whitepanda,
                                      ),
                                        child: DropdownButton(
                                          hint: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 18),
                                            child: CustomText(
                                              text:"Year",
                                              fontSize: 12,
                                            ),
                                          ),
                                          underline: SizedBox(),
                                          icon: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 15),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Global.orangepanda,
                                              size: 20.09,
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: yearlist.map((val) {
                                            return DropdownMenuItem(
                                              value: val,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: CustomText(
                                                  text:val,
                                                  fontSize: 8,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          value: year,
                                          onChanged: (value) {
                                            setState(() {
                                              year = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text:"Gender",
                                fontSize: 12.5,                              ),
                              Row(
                                children: <Widget>[
                                  Radio(
                                    value: 1,
                                    groupValue: selectedRadio,
                                    activeColor: Global.orangepanda,
                                    onChanged: (val) {
                                      print("Radio $val");

                                      setSelectedRadio(val);
                                    },
                                  ),
                                  new CustomText(
                                    text:'Male',

                                        fontSize: 12,
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: selectedRadio,
                                    activeColor: Global.orangepanda,
                                    onChanged: (val) {
                                      print("Radio $val");

                                      setSelectedRadio(val);
                                    },
                                  ),
                                  new CustomText(text:'Female',
                                          fontSize: 12,
                                      ),
                                  Radio(
                                    value: 3,
                                    groupValue: selectedRadio,
                                    activeColor: Global.orangepanda,
                                    onChanged: (val) {
                                      print("Radio $val");

                                      setSelectedRadio(val);
                                    },
                                  ),
                                  new CustomText(text:'Unknown',

                                          fontSize: 12,
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                     /*   Customtextfield(
                          hinttext: "Change E-mail...",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Customtextfield(obsecuretext: true,
                          hinttext: "Change Password...",
                        ),*/
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: customraisedbutton(
                                  click: (){
                                    onSubmit();
                                  },
                              text: "Save",
                              clr: Global.whitepanda,
                              bgclr: Global.orangepanda,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: customraisedbutton(
                                  click: (){_showDialog();},
                              text: "About US",
                              clr: Global.whitepanda,
                              bgclr: Global.darkgrey,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: customraisedbutton(
                                  click: (){
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('login', (r) => false);
                                  },
                              text: "LOGOUT",
                              clr: Global.whitepanda,
                              bgclr: Global.darkgrey,
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: customraisedbutton(
                              text: "DELETE ACCOUNT",
                              bgclr: Global.darkBlue,
                              clr: Global.whitepanda,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  onSubmit() async {

    ProgressDialog(context);

    print(username.text);
    print(_currentSelectedItemgame);
    print(_currentSelectedItemgame2);
    print(_currentSelectedItemcountry);
    print(_currentSelectedItemrank);
    print(_currentSelectedItemserver);
    print(_currentSelectedItemserver);
    print(day);
    print(month);
    print(year);
    print(gender[selectedRadio]);

    await http.post("https://pandaweb20200510045646.azurewebsites.net/api/Panda/profile/OwnUserProfile",
        body:{
        "UserId": Global.User.uid,
        "UserName": username.text.toString(),
        "Game":_currentSelectedItemgame,
        "Game2":_currentSelectedItemgame2,
        "Server":_currentSelectedItemserver,
        "Rank":_currentSelectedItemrank,
        "Country":_currentSelectedItemcountry,
        "Gender":gender[selectedRadio],
        "Email":Global.User.email,
        "Password":"",
        "Day":day,
        "Month":(Monthlist.indexOf(month)+1).toString(),
        "Year":year,
        }
    ).then((response){
      print("There is no Response : "+response.body);
    });

    await GetUserDeatils();

    Navigator.of(context).pop();
    Fluttertoast.showToast(msg: "Details Updated");
    setState(() {

    });


  }



// user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("About Us"),
          content: SingleChildScrollView(child: new Text("is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
