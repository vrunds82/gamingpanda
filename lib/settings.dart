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
    return Scaffold(appBar: CustomAppbarforsettings,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),

                  Expanded(flex: 8,
                      child: Customtextfield(obsecuretext: false,controllername:username ,hinttext: "Username...",align: false,focusborder: false,)),
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),
                ],
              ),
              SizedBox(height: 10,),

          //dropdown1
            Row(
              children: <Widget>[
                Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),
                Expanded(
                  flex:8,
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

                        child: DropdownButton(hint: Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Text("League of Legends",style: TextStyle(fontSize: 12),),
                        ),underline: SizedBox(),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color:Global.orangepanda,
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
                ),
                Expanded(flex: 1,child: Icon(Icons.cancel,color: Global.greypandaicon,),),
              ],
            ),
              SizedBox(height: 10,),
//dropdown2

              Row(
                children: <Widget>[
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),
                  Expanded(flex: 8,
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
                            child: DropdownButton(hint: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text("Game2",style: TextStyle(fontSize: 12),),
                            ),underline: SizedBox(),
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color:Global.orangepanda,
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
                  ),
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Global.greypandaicon),),

                ],
              ),
              SizedBox(height: 10,),

              //drowndown3

              Row(
                children: <Widget>[
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),

                  Expanded(flex: 8,
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
                            child: DropdownButton(hint: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text("Server",style: TextStyle(fontSize: 12),),
                            ),underline: SizedBox(),
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color:Global.orangepanda,
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
                  ),
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Global.greypandaicon),),

                ],
              ),
              SizedBox(height: 10,),

              //dropdown4
              Row(
                children: <Widget>[
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),

                  Expanded(flex: 8,
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
                            child: DropdownButton(hint: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text("Rank",style: TextStyle(fontSize: 12),),
                            ),underline: SizedBox(),
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color:Global.orangepanda,
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
                  ),
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Global.greypandaicon),),

                ],
              ),
              SizedBox(height: 10,),

              //dropdown5
              Row(
                children: <Widget>[
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Colors.transparent),),

                  Expanded(flex: 8,
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
                            child: DropdownButton(hint: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text("Country",style: TextStyle(fontSize: 12),),
                            ),underline: SizedBox(),
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color:Global.orangepanda,
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
                  ),
                  Expanded(flex: 1,child: Icon(Icons.cancel,color:Global.greypandaicon),),

                ],
              ),
              SizedBox(height: 10,),



              //DOB
              Row(
                children: <Widget>[
                  Expanded(flex:1,child: SizedBox(),),
                  Expanded(flex: 8,
                    child: Column(mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Date of Birth",textAlign: TextAlign.left,style: TextStyle(
                                fontSize: 12
                              ),),

                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Container(width: 75,

                                child: Container(width: 120,

                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Global.greypandaicon,

                                    ),

                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),

                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: DropdownButton(hint: Padding(
                                          padding: const EdgeInsets.only(left: 13),
                                          child: Text("Day",style: TextStyle(
                                            fontSize: 12
                                          ),),
                                        ),underline: SizedBox(),
                                          icon: Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color:Global.orangepanda,
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

                            Container(width: 100,

                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Global.greypandaicon,

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
                                          color:Global.orangepanda,
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
                                      color: Global.greypandaicon,

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
                                              color:Global.orangepanda,
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
  padding: const EdgeInsets.only(left: 10),

  child:   Column(crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(height: 10,),
      Text("Gender",style: TextStyle(fontSize: 12.5),),
      Row(children: <Widget>[
        Radio(
          value: 1,
          groupValue: selectedRadio,
          activeColor: Global.orangepanda,
          onChanged: (val) {

            print("Radio $val");

            setSelectedRadio(val);

          },

        ),

        new Text('Male',style: TextStyle(fontSize: 12,color: Global.greypanda),),

        Radio(

          value: 2,

          groupValue: selectedRadio,

          activeColor: Global.orangepanda,

          onChanged: (val) {

            print("Radio $val");

            setSelectedRadio(val);

          },

        ),

        new Text('Female',style: TextStyle(fontSize: 12,color: Global.greypanda)),

        Radio(

          value: 3,

          groupValue: selectedRadio,

          activeColor: Global.orangepanda,

          onChanged: (val) {

            print("Radio $val");

            setSelectedRadio(val);

          },

        ),

        new Text('Unknown',style: TextStyle(fontSize: 12,color: Global.greypanda)),

      ],),
    ],
  ),

),
                        SizedBox(height: 10,),
                        Customtextfield(hinttext: "Change E-mail...",),
                        SizedBox(height: 10,),
                        Customtextfield(hinttext: "Change Password...",),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(child: customraisedbutton(text: "Save",clr: Global.whitepanda,bgclr: Global.orangepanda,)),
                          ],
                        ),
SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(child: customraisedbutton(text: "SAVE",clr: Global.whitepanda,bgclr: Global.darkgrey,)),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(child: customraisedbutton(text: "LOGOUT",clr: Global.whitepanda,bgclr: Global.darkgrey,)),
SizedBox(width: 10,),
                            Expanded(child: customraisedbutton(text: "DELETE ACCOUNT",bgclr: Global.blackpanda,clr: Global.whitepanda,)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex:1,child: SizedBox(),),
                ],
              ),
SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
