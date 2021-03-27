import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Global {
  static String token;

  static List<String> dates = new List();

  //https://pandagamingweb2020.azurewebsites.net/
  //static String BaseURL = "https://pandaweb20200605061105.azurewebsites.net/api/panda/";
  static String BaseURL =
      "https://pandapanweaker.azurewebsites.net/api/panda/";
  static double width = 100;
  static double height = 500;
  static bool isSwitchedFT = true;
  static double fontsize = 14;
  static Color orangepanda = Color(0xffFF781E);
  static Color whitepanda = Color(0xffF8F8F8);
  static Color greypanda = Color(0xff9A9A9A);
  static Color greypandaicon = Color(0xffDBD8D5);
  static Color blackpanda = Color(0xff252531);
  static Color lightorangepanda = Color(0xffFE9335);
  static Color darkgrey = Color(0xff9F9F9F);
  static Color yellowpanda = Color(0xffFCCF31);
  static Color darkBlue = Color(0xff16161D);
  static Color SuperLikeBlue = Color(0xff6B73FF);
  static int currentpageindex = 1;
  static double IconSize = 0.06;
  static FirebaseUser User;
  static UserData userData;
  static Profile OtherUserProfile;
  static String OtherUserId = "arunarun";
  static int noOfUsers =0;
  static bool firstLogin = false;
  static int superPlay=3;


// web Globals
  static bool isweb = false;
  static double webwidth;
  static int webCurrentPageIndex;

//Images

}

class myMessagesTile extends StatelessWidget {
  DocumentSnapshot documentSnapshot;

  myMessagesTile({this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: documentSnapshot.data['image'] == null ||
                                    documentSnapshot.data['image'] == ""
                                ? AssetImage('assets/images/logo.png')
                                : NetworkImage(documentSnapshot.data['image']),
                          ))),
                  Positioned(
                    right: 8,
                    bottom: 5,
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                            child: Icon(
                          Icons.brightness_1,
                          color: Global.orangepanda,
                          size: 13,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: documentSnapshot.data['name'] ?? "",
                        fontSize: 18,
                      ),
                      Text(
                        documentSnapshot.data['msg'] ?? "",
                        style: TextStyle(
                          fontWeight: documentSnapshot.data['read']!=null && documentSnapshot.data['read']?FontWeight.normal:FontWeight.bold,
                            fontSize: 15, color: documentSnapshot.data['read']!=null && documentSnapshot.data['read']?Colors.grey:Global.orangepanda),
                        textAlign: TextAlign.left,

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Customtextfield extends StatelessWidget {
  TextEditingController controllername = TextEditingController();

  String hinttext;
  bool obsecuretext;
  bool align;
  bool focusborder;
  var validate;
  Function onsubmit;

  Customtextfield(
      {this.controllername,
      this.obsecuretext,
      this.hinttext,
      this.align,
      this.focusborder,
      this.validate,
      this.onsubmit});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onsubmit ?? (_) {},
      obscureText: obsecuretext ?? false,
      style: TextStyle(color: Global.orangepanda),
      controller: controllername,
      textAlign: align == true ? TextAlign.center : TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hinttext,
        labelStyle: TextStyle(color: Global.greypanda, fontSize: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Global.orangepanda, width: 2.0),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),

        // hintText: 'Enter a product name eg. pension',
        hintStyle: TextStyle(
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
        ),

        filled: true,
        contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
        fillColor: Colors.white.withOpacity(0.2),
      ),
    );
  }
}

class customraisedbutton extends StatelessWidget {
  String text;
  Color clr;
  Color bgclr;
  VoidCallback click;

  customraisedbutton({this.text, this.click, this.clr, this.bgclr});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: bgclr,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      onPressed: () {
        click();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 17, bottom: 17),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: clr,
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}

class customtext extends StatelessWidget {
  String text;

  customtext({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Global.greypanda,
        fontSize: 16,
      ),
    );
  }
}

/*AppBar CustomAppbar =  AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: Global.whitepanda,title: Row(children: <Widget>[
  Image.asset(Global.currentpageindex==0?'assets/images/usergrey.png':
    'assets/images/userorange.png',height: 20,width: 20,

    ),
  Spacer(),
  Image.asset(Global.currentpageindex==1?'assets/images/pandagrey.png':
  'assets/images/pandaorange.png',height: 20,width: 20,),
  Spacer(),
  Image.asset('assets/images/chatgrey.png',height: 20,width: 20,),

],),);*/

class CustomAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          //height: MediaQuery.of(context).size.width * .2,
          color:
              Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Global.currentpageindex = 0;
                      Navigator.of(context).pushReplacementNamed('profile');
                    },
                    child: Image.asset(
                      Global.currentpageindex == 0
                          ? 'assets/images/userorange.png'
                          : 'assets/images/usergrey.png',
                      height:
                          MediaQuery.of(context).size.width * Global.IconSize,
                      width:
                          MediaQuery.of(context).size.width * Global.IconSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Global.currentpageindex = 1;
                      Navigator.of(context).pushReplacementNamed('cardswipe');
                    },
                    child: Image.asset(
                      Global.currentpageindex == 1
                          ? 'assets/images/pandaorange.png'
                          : 'assets/images/pandagrey.png',
                      height:
                          MediaQuery.of(context).size.width * Global.IconSize,
                      width:
                          MediaQuery.of(context).size.width * Global.IconSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Global.currentpageindex = 2;
                      Navigator.of(context).pushReplacementNamed('chat');
                    },
                    child: Image.asset(
                      Global.currentpageindex == 2
                          ? 'assets/images/chatorange.png'
                          : 'assets/images/chatgrey.png',
                      height:
                          MediaQuery.of(context).size.width * Global.IconSize,
                      width:
                          MediaQuery.of(context).size.width * Global.IconSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: Global.isSwitchedFT ? 0 : 0.5,
          color: Colors.grey,
        ),
      ],
    );
  }
}

/*
class CustomAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Global.whitepanda,title: Row(children: <Widget>[
      Image.asset(Global.currentpageindex==0?'assets/images/usergrey.png':
      'assets/images/userorange.png',height: 20,width: 20,

      ),
      Spacer(),
      Image.asset(Global.currentpageindex==1?'assets/images/pandagrey.png':
      'assets/images/pandaorange.png',height: 20,width: 20,),
      Spacer(),
      Image.asset('assets/images/chatgrey.png',height: 20,width: 20,),

    ],),);
  }
}*/

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> listitems = ['A', 'B', 'C', 'D'];

  var _currentSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Global.greypandaicon,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: DropdownButton(
              hint: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(""),
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
                    child: Text(val),
                  ),
                );
              }).toList(),
              value: _currentSelectedItem,
              onChanged: (value) {
                setState(() {
                  _currentSelectedItem = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class customcard extends StatelessWidget {
  VoidCallback onclick;
  VoidCallback onRemove;
  String ImageURL;
  File file;

  customcard({this.onclick, this.file, this.ImageURL, this.onRemove});

  @override
  Widget build(BuildContext context) {
    var _image;
    return Stack(children: [
      Container(
        height: Global.isweb
            ? MediaQuery.of(context).size.width * .1
            : MediaQuery.of(context).size.width * .4,
        width: Global.isweb
            ? MediaQuery.of(context).size.width * .075
            : MediaQuery.of(context).size.width * .3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              onclick();
            },
            child: Card(
              color: Global.isSwitchedFT == true
                  ? Global.darkBlue.withOpacity(0.5)
                  : Global.whitepanda,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: file != null
                      ? Image.file(
                          file,
                          fit: BoxFit.cover,
                        )
                      : ImageURL == null || ImageURL == ""
                          ? SizedBox()
                          : Image.network(
                              ImageURL,
                              fit: BoxFit.cover,
                            )),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              print("asdfasdf");
              onclick();
            },
            child: Container(
              //    color: Colors.red,

              child: Icon(
                Icons.add_circle,
                color: Global.orangepanda,
                size: 28,
              ),
            ),
          )),
      ImageURL != "null" && ImageURL != null
          ? Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  print("asdfasdf" + ImageURL);

                  onRemove();
                },
                child: Container(
                  //    color: Colors.red,

                  child: Icon(
                    Icons.remove_circle,
                    color: Global.orangepanda,
                    size: 28,
                  ),
                ),
              ))
          : SizedBox(),
    ]);
  }
}

AppBar CustomAppbarforchat = AppBar(
  backgroundColor:
      Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/user.png'),
              ))),
      SizedBox(
        width: 5,
      ),
      CustomText(
        text: "Ivana",
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),

      // For Adjusting Space
      Opacity(
        opacity: 0,
        child: Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(left: 20, top: 15, bottom: 10),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/user.png'),
                ))),
      ),
      SizedBox(
        width: 5,
      ),
    ],
  ),
  centerTitle: true,
  actions: <Widget>[
    Icon(
      Icons.more_vert,
      color: Global.orangepanda,
    ),
  ],
);

class customgradientbuton extends StatelessWidget {
  String buttontext;
  VoidCallback onClicked;

  customgradientbuton({this.buttontext, this.onClicked});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        onClicked();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Global.yellowpanda, Global.orangepanda],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            buttontext,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

AppBar CustomAppbarforsettings = AppBar(
  automaticallyImplyLeading: false,
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
      Container(
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
);

class CustomButton extends StatelessWidget {
  String text;
  Icon icon;
  Color textColor;
  Color backgroundColor;
  VoidCallback onPressed;

  CustomButton(
      {this.text,
      this.icon,
      this.textColor,
      this.backgroundColor,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .55,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(211, 211, 211, 0.4),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  )),
              Expanded(
                  child: Center(
                      child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w900, color: textColor),
              ))),
              Opacity(
                opacity: 0,
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(211, 211, 211, 0.4),
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: icon,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  String text;
  FontWeight fontWeight;
  double fontSize;
  Color color;
  TextDecoration decoration;

  CustomText(
      {this.text, this.fontWeight, this.fontSize, this.color, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color == null
              ? Global.isSwitchedFT == false
                  ? Global.blackpanda
                  : Global.whitepanda
              : color,
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 13,
          decoration: decoration ?? TextDecoration.none),
    );
  }
}

class CustomProfileRoundButton extends StatelessWidget {
  final VoidCallback onClick;
  final String myText;
  final String img;
  final Color textColor;

  CustomProfileRoundButton(
      {this.onClick, this.myText, this.img, this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          Image.asset(
            img,
            width: MediaQuery.of(context).size.width * .15,
          ),

          Text(
            myText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor == null
                    ? Global.isSwitchedFT == false
                        ? Global.blackpanda
                        : Global.whitepanda
                    : textColor,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class BuyCoinCards extends StatelessWidget {
  final String image;
  final String coins;
  final String price;
  final Color cardColor;
  final VoidCallback onClick;
  final Color textColor;

  BuyCoinCards(
      {this.image,
      this.coins,
      this.price,
      this.cardColor,
      this.onClick,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          decoration: BoxDecoration(
            color: cardColor == null ?? Global.isSwitchedFT == true
                ? Colors.black38
                : Global.whitepanda,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * .05,
              bottom: MediaQuery.of(context).size.width * .05,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 25),
                  child: Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width * .15,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    coins == "100"
                        ? Container(
                            decoration: BoxDecoration(
                              color: Global.orangepanda,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            //color: Global.orangepanda,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  bottom: 2.0,
                                  top: 2.0),
                              child: Text(
                                "BEST OFFER",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Text(
                      "$coins COINS",
                      style: TextStyle(
                          color: textColor == null
                              ? Global.isSwitchedFT == false
                                  ? Global.blackpanda
                                  : Global.whitepanda
                              : textColor,
                          //height: -1,
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width * .055),
                    ),
                    Text(
                      "BUY NOW",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: textColor == null
                              ? Global.isSwitchedFT == false
                                  ? Global.blackpanda
                                  : Global.whitepanda
                              : textColor,
                          height: 1,
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width * .035),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    "$price\$",
                    style: TextStyle(
                        fontSize: 25,
                        color: textColor == null
                            ? Global.isSwitchedFT == false
                                ? Global.blackpanda
                                : Global.whitepanda
                            : textColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumPriceCard extends StatelessWidget {
  final String myPlan;
  final String planPrice;
  final VoidCallback onClick;
  final String discountText;

  PremiumPriceCard(
      {this.myPlan, this.planPrice, this.onClick, this.discountText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: MediaQuery.of(context).size.width * .3,
        width: MediaQuery.of(context).size.width * .25,
        decoration: BoxDecoration(
          color: Color(0xff494B56),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "$myPlan",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: MediaQuery.of(context).size.width * .025),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "\$$planPrice/MONTH",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Global.orangepanda,
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * .028),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Global.orangepanda,
                borderRadius: BorderRadius.circular(100.0),
              ),
              //color: Global.orangepanda,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 2.0, top: 2.0),
                child: Text(
                  discountText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BoostDialogBox extends StatefulWidget {
  final String icon;
  final String upperText;
  final String lowerText;
  final String totalCoin;
  final Color iconColor;

  BoostDialogBox(
      {this.icon,
      this.upperText,
      this.lowerText,
      this.totalCoin,
      this.iconColor});

  @override
  _BoostDialogBoxState createState() => _BoostDialogBoxState();
}

class _BoostDialogBoxState extends State<BoostDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)), //this right here
      child: Container(
        height: MediaQuery.of(context).size.width * .9,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.upperText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * .04,
                  ),
                ),
              ),
              //coin +-
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Sub coin
                  GestureDetector(
                    onTap: () {
                      print("ON Minus Click");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .08,
                      height: MediaQuery.of(context).size.width * .08,
                      child: CircleAvatar(
                        backgroundColor: widget.iconColor,
                        child: Center(
                            child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ),
                  //Coin
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey[400]),
                        borderRadius: BorderRadius.circular(100)),
                    height: MediaQuery.of(context).size.width * .1,
                    width: MediaQuery.of(context).size.width * .4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/coin10.png",
                          ),
                        ),
                        Text(
                          "1000",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * .05),
                        ),
                      ],
                    ),
                  ),
                  //Add Coin
                  GestureDetector(
                    onTap: () {
                      print("ON Add Click");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .08,
                      height: MediaQuery.of(context).size.width * .08,
                      child: CircleAvatar(
                        backgroundColor: widget.iconColor,
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  )
                ],
              ),
              // Arrow
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SvgPicture.asset(
                        "assets/images/arrow.svg",
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width * .1,
                        height: MediaQuery.of(context).size.width * .1,
                      ),
                    ),
                  ),
                ],
              ),
              //Boost icon and no of boost
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.icon,
                    width: MediaQuery.of(context).size.width * .1,
                  ),
                  Text(
                    "500",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.width * .07,
                      color: widget.iconColor,
                    ),
                  )
                ],
              ),

              //Convert
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Convert");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Global.orangepanda,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      //color: Global.orangepanda,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 2.0, top: 2.0),
                        child: Text(
                          "CONVERT",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.0,),
              //Buy more coins button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("ON Buy more Click");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                       gradient: LinearGradient(
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
                         colors: [const Color(0xFFFCCF31), const Color(0xFFCE922F )], // whitish to gray
                         //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                       ),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      //color: Global.orangepanda,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 2.0, top: 2.0),
                        child: Text(
                          "BUY MORE COINS",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.lowerText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Global.isSwitchedFT == true
                        ? Colors.black
                        : Colors.white,
                    fontSize: MediaQuery.of(context).size.width * .025,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// user defined function

void ProgressDialog(context, {String msg}) {
  // flutter defined function
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                  Text(msg ?? "")
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

SendNotification(
    {String title,
    String body,
    Map<String, dynamic> data,
    String userId,
    String chat}) async {
  print("Sending Notification");


  String token;
  print(Global.userData.userId);
  await http.post("${Global.BaseURL}profile/GetToken",
      body: {"UserID": userId}).then((value) {
        print("AÀ");
    token = value.body;
    print("TOKEN : "+token);

  });



  Map<String, String> data = {
    'chat': chat ?? 'no',
    'uid': Global.User.uid,
    'name': title,
    'image': "",
    'content': body
  };

  // Replace with server token from firebase console settings.
  final String serverToken =
      'AAAAFA6EFDc:APA91bH0UQSM4KRrmHdl4ZvdT3wm1Ow5bDn9-PfarK2RoXd26yo5OyHTLiUElsJvzQWTp8FH1a-J19Na6h9kcvxejzVCge4YS-9CadDNSvy5GWNGbxJUMm6xa8cwSlMlCDRkzCJo1ph2';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  await http
      .post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': body ?? "0",
          'title': title ?? "0"
        },
        'priority': 'high',
        'data': data ?? {},
        'to': token,
      },
    ),
  )
      .then((value) {
    print("Response From Notificaiton : " + value.body);
  }).catchError((onError) {
    print(onError);
    print(onError.message);
  });
}
