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

  List<String> Monthlist = ["January", "February", "March", "April",

  "May","June","July","August","September","October","November","December"];

  List<String> daylist = ["1", "2", "3", "4",

    "5","6","7","8","9","10","11","12"];

  List<String> yearlist = ["1990", "1991", "1992", "1993",

    "1994","1995","1996","1997","1998","1999","2000","2001"];




  String day,month,year;

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Customtextfield(obsecuretext: false,controllername:username ,hinttext: "Username...",align: false,focusborder: false,),
              SizedBox(height: 10,),

          //dropdown1
          Container(

            decoration: BoxDecoration(
              border: Border.all(
                color: greypandaicon,

              ),

              borderRadius: BorderRadius.all(Radius.circular(30.0)),

            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton(hint: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text("League of Legends",style: TextStyle(fontSize: 12),),
                  ),underline: SizedBox(),
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color:orangepanda,
                        size: 20.09,
                      ),
                    ),
                    isExpanded: true,
                    items: listitems.map((val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(val),
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
              ],
            ),
          ),
              SizedBox(height: 10,),
//dropdown2

              Container(

                decoration: BoxDecoration(
                  border: Border.all(
                    color: greypandaicon,

                  ),

                  borderRadius: BorderRadius.all(Radius.circular(30.0)),

                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("League of Legends",style: TextStyle(fontSize: 12),),
                      ),underline: SizedBox(),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color:orangepanda,
                            size: 20.09,
                          ),
                        ),
                        isExpanded: true,
                        items: listitems.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(val,style: TextStyle(fontSize: 12),),
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
                  ],
                ),
              ),
              SizedBox(height: 10,),

              //drowndown3

              Container(

                decoration: BoxDecoration(
                  border: Border.all(
                    color: greypandaicon,

                  ),

                  borderRadius: BorderRadius.all(Radius.circular(30.0)),

                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("League of Legends",style: TextStyle(fontSize: 12),),
                      ),underline: SizedBox(),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color:orangepanda,
                            size: 20.09,
                          ),
                        ),
                        isExpanded: true,
                        items: listitems.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(val,style: TextStyle(fontSize: 12),),
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
                  ],
                ),
              ),
              SizedBox(height: 10,),

              //dropdown4
              Container(

                decoration: BoxDecoration(
                  border: Border.all(
                    color: greypandaicon,

                  ),

                  borderRadius: BorderRadius.all(Radius.circular(30.0)),

                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("League of Legends",style: TextStyle(fontSize: 12),),
                      ),underline: SizedBox(),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color:orangepanda,
                            size: 20.09,
                          ),
                        ),
                        isExpanded: true,
                        items: listitems.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(val,style: TextStyle(fontSize: 12)),
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
                  ],
                ),
              ),
              SizedBox(height: 10,),

              //dropdown5
              Container(

                decoration: BoxDecoration(
                  border: Border.all(
                    color: greypandaicon,

                  ),

                  borderRadius: BorderRadius.all(Radius.circular(30.0)),

                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Text("League of Legends",style: TextStyle(fontSize: 12),),
                      ),underline: SizedBox(),
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color:orangepanda,
                            size: 20.09,
                          ),
                        ),
                        isExpanded: true,
                        items: listitems.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(val,style: TextStyle(fontSize: 12)),
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
                  ],
                ),
              ),
              SizedBox(height: 10,),



              //DOB
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Date of Birth",textAlign: TextAlign.left,),
                  ],
                ),
              ),

              Row(
                children: <Widget>[
                  Container(width: 80,

                      child: Container(width: 120,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greypandaicon,

                          ),

                          borderRadius: BorderRadius.all(Radius.circular(30.0)),

                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: DropdownButton(hint: Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text("Day",style: TextStyle(
                                  fontSize: 12
                                ),),
                              ),underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color:orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: daylist.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(val,style: TextStyle(fontSize: 10),),
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
                          ],
                        ),
                      ),),
SizedBox(width: 10,),

                  Container(width: 120,

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: greypandaicon,

                      ),

                      borderRadius: BorderRadius.all(Radius.circular(30.0)),

                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: DropdownButton(hint: Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text("Month",style: TextStyle(
                                fontSize: 12
                            ),),
                          ),underline: SizedBox(),
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color:orangepanda,
                                size: 20.09,
                              ),
                            ),
                            isExpanded: true,
                            items: Monthlist.map((val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(val,style: TextStyle(fontSize: 10),),
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
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(width: 80,

                      child: Container(width: 120,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greypandaicon,

                          ),

                          borderRadius: BorderRadius.all(Radius.circular(30.0)),

                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: DropdownButton(hint: Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text("Year",style: TextStyle(
                                    fontSize: 12
                                ),),
                              ),underline: SizedBox(),
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color:orangepanda,
                                    size: 20.09,
                                  ),
                                ),
                                isExpanded: true,
                                items: yearlist.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(val,style: TextStyle(fontSize: 8),),
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
                          ],
                        ),
                      ),),
                ],
              ),
Padding(
  padding: const EdgeInsets.only(left: 12),

  child:   Row(children: <Widget>[

    Text("Gender"),

    Radio(
      value: 1,
      groupValue: selectedRadio,
      activeColor: orangepanda,
      onChanged: (val) {

        print("Radio $val");

        setSelectedRadio(val);

      },

    ),

    new Text('Male'),

    Radio(

      value: 2,

      groupValue: selectedRadio,

      activeColor: orangepanda,

      onChanged: (val) {

        print("Radio $val");

        setSelectedRadio(val);

      },

    ),

    new Text('Female'),

    Radio(

      value: 3,

      groupValue: selectedRadio,

      activeColor: orangepanda,

      onChanged: (val) {

        print("Radio $val");

        setSelectedRadio(val);

      },

    ),

    new Text('Unknown'),

  ],),

),
              SizedBox(height: 10,),
              Customtextfield(hinttext: "Change E-mail...",),
              SizedBox(height: 10,),
              Customtextfield(hinttext: "Change Password...",),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(child: customraisedbutton(text: "Save",clr: whitepanda,bgclr: orangepanda,)),
                ],
              ),

              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(child: customraisedbutton(text: "LogOut",clr: whitepanda,bgclr: darkgrey,)),
SizedBox(width: 10,),
                  Expanded(child: customraisedbutton(text: "Delete Account",bgclr: blackpanda,clr: whitepanda,)),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
