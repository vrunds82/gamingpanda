import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/Lists.dart';
import 'package:http/http.dart' as http;



import 'global.dart';

class filteritem extends StatefulWidget {
  @override
  _filteritemState createState() => _filteritemState();
}

class _filteritemState extends State<filteritem> {



  double start=Global.userData.filterAgeStart==""||Global.userData.filterAgeStart==null ||Global.userData.filterAgeStart<15 ?15: Global.userData.filterAgeStart.toDouble();
  double end=Global.userData.filterAgeEnd==""||Global.userData.filterAgeEnd==null ||Global.userData.filterAgeEnd<15?15: Global.userData.filterAgeEnd.toDouble();

  var _currentSelectedItemserver= Global.userData.filterServer;
  var _currentSelectedItemrank = Global.userData.filterRank;
  var _currentSelectedItemcountry = Global.userData.filterCountry;
  var _currentSelectedItemgame = Global.userData.filterGame;


  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = Global.userData.filterGender==null||Global.userData.filterGender==""?0:["","Male","Female","Any"].indexOf(Global.userData.filterGender);
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.isSwitchedFT == true
          ? Global.blackpanda
          : Global.whitepanda,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 60),
          child: Column(children: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomText(text:"Filters",
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ,),
              ],
            ),
            SizedBox(height: 10,),
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomText(text:"I am looking for:",
                  fontSize:12,
                ),
              ],
            ),
SizedBox(height: 10,),
            Container(

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
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: CustomText(text:"Game",fontSize: 12,),
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
                        items: Games.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomText(text:val,fontSize: 12,),
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
            SizedBox(height: 10,),

            //drowndown3

            Container(

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
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: CustomText(text:"Server",fontSize: 12,),
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
                        items: Server.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomText(text:val,fontSize: 12,),
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
            SizedBox(height: 10,),

            //dropdown4
            Container(

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
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: CustomText(text:"Rank",fontSize: 12),
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
                        items: Rank.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomText(text:val,fontSize: 12),
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
            SizedBox(height: 10,),

            //dropdown5
            Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: Global.greypandaicon,

                ),

                borderRadius: BorderRadius.all(Radius.circular(30.0)),

              ),
              child: Row(
                children: <Widget>[
                  Theme(data: Theme.of(context).copyWith(
                    canvasColor: Global.isSwitchedFT == true
                        ? Global.blackpanda
                        : Global.whitepanda,
                  ),
                    child: Expanded(
                      child: DropdownButton(hint: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: CustomText(text:"Country",fontSize: 12,),
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
                        items: countryList.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomText(text:val,fontSize: 12),
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
            SizedBox(height: 10,),
            Row(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomText(text:"Age",

                    fontSize: 12
                ,),
              ],
            ),

Row(
  children: <Widget>[
    Container(
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Global.greypandaicon)

        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
          child: CustomText(text:start.toInt().toString()+" - "+end.toInt().toString(),fontSize: 13,),
        )),

        Expanded(
          child: Theme(
            data: ThemeData(backgroundColor:Global.darkBlue),
            child: RangeSlider(

              values: RangeValues(start,end),
     onChanged: (values){

            start=values.start;
            end=values.end;

            setState(() {

            });
     },
      min: 15,
      max: 60,
              activeColor: Global.orangepanda,
              inactiveColor: Global.isSwitchedFT == true
                  ? Global.whitepanda
                  : Global.blackpanda,



    ),
          ),
        ),
  ],
),
            Padding(
              padding: const EdgeInsets.only(left: 3),

              child:   Row(children: <Widget>[

                CustomText(text:"Gender",fontSize: 12.5,),

                Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  activeColor: Global.orangepanda,
                  onChanged: (val) {

                    print("Radio $val");

                    setSelectedRadio(val);

                  },

                ),

                new CustomText(text:'Male',fontSize: 12),

                Radio(

                  value: 2,

                  groupValue: selectedRadio,

                  activeColor: Global.orangepanda,

                  onChanged: (val) {

                    print("Radio $val");

                    setSelectedRadio(val);

                  },

                ),

                new CustomText(text:'Female',fontSize: 12),

                Radio(

                  value: 3,

                  groupValue: selectedRadio,

                  activeColor: Global.orangepanda,

                  onChanged: (val) {

                    print("Radio $val");

                    setSelectedRadio(val);

                  },

                ),

                new CustomText(text:'Any',fontSize: 12),

              ],),


            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Expanded(child: customraisedbutton(text: "SAVE",bgclr: Global.orangepanda,clr: Global.whitepanda,click: (){
                  onSubmit();
                },)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Expanded(child: customraisedbutton(text: "BACK",bgclr: Global.orangepanda,clr: Global.whitepanda,
                click: (){

                  Navigator.pop(context);
                },)),

              ],
            )
          ],),
        ),
      ),
    );
  }

  onSubmit() async {


    ProgressDialog(context);

    print(Global.User.uid);
    print(_currentSelectedItemgame);
    print(_currentSelectedItemcountry);
    print(_currentSelectedItemrank);
    print(_currentSelectedItemserver);
    print(_currentSelectedItemserver);
    print(gender[selectedRadio]);
    print(start);
    print(end);

    print("calling..");
 await  http.post("${Global.BaseURL}profile/updateFilter",
      body:{
        "UserId": Global.User.uid,
        "Game":_currentSelectedItemgame??"null",
        "Server":_currentSelectedItemserver??"null",
        "Rank":_currentSelectedItemrank??"null",
        "Country":_currentSelectedItemcountry??"null",
        "Gender":gender[selectedRadio]??"Male",
        "AgeStart":start.toInt().toString()??"0",
        "AgeEnd":end.toInt().toString()??"0"
      }
    ).then((response){
      print(response.statusCode);
      print(response.body);
    }).catchError((error){print("Error : "+error.toString());});

    Fluttertoast.showToast(msg : "Details Updated");
    await GetUserDeatils();
    Navigator.of(context).pop();
  }

}
