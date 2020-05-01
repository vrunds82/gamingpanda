import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class settingpage extends StatefulWidget {
  @override
  _settingpageState createState() => _settingpageState();
}

class _settingpageState extends State<settingpage> {
  TextEditingController username = TextEditingController();

  List<String> listitems = ['A', 'B', 'C', 'D'];

  List<String> Monthlist = [
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
    "12"
  ];

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
    "2001"
  ];

  String day, month, year;

  var _currentSelectedItemserver;

  var _currentSelectedItemrank;

  var _currentSelectedItemcountry;

  var _currentSelectedItemgame;

  var _currentSelectedItemleg;
// Declare this variable
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
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
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
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
                                      text:"League of Legends",
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
                                  items: listitems.map((val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CustomText(text:val),
                                      ),
                                    );
                                  }).toList(),
                                  value: _currentSelectedItemleg,
                                  onChanged: (value) {
                                    setState(() {
                                      _currentSelectedItemleg = value;
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
                      child: Icon(
                        Icons.cancel,
                        color: Global.greypandaicon,
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
                                      "Game2",
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
                                  items: listitems.map((val) {
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
                      child: Icon(Icons.cancel, color: Global.greypandaicon),
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
                                  items: listitems.map((val) {
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
                      child: Icon(Icons.cancel, color: Global.greypandaicon),
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
                                  items: listitems.map((val) {
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
                      child: Icon(Icons.cancel, color: Global.greypandaicon),
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
                                  items: listitems.map((val) {
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
                      child: Icon(Icons.cancel, color: Global.greypandaicon),
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
                          Customtextfield(
                            hinttext: "Change E-mail...",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Customtextfield(obsecuretext: true,
                            hinttext: "Change Password...",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: customraisedbutton(
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
      ),
    );
  }
}
