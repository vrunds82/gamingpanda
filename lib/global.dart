

import 'package:flutter/material.dart';


class Global{

  static bool isSwitchedFT = false;
  static double fontsize=14;
  static Color orangepanda = Color(0xffFF781E);
  static Color whitepanda = Color(0xffF8F8F8);
  static Color greypanda = Color(0xff9A9A9A);
  static Color  greypandaicon = Color(0xffDBD8D5);
  static Color blackpanda = Color(0xff252531);
  static Color  lightorangepanda = Color(0xffFE9335);
  static Color darkgrey = Color(0xff9F9F9F);
  static Color yellowpanda  = Color(0xffFCCF31);


  static int currentpageindex = 1;


}






class Customtextfield extends StatelessWidget {

TextEditingController controllername = TextEditingController();


String hinttext;
bool obsecuretext;
bool align;
bool focusborder;

  Customtextfield({this.controllername,this.obsecuretext,this.hinttext,this.align,this.focusborder});


  @override
  Widget build(BuildContext context) {
    return TextField(obscureText: obsecuretext??false,
     style: TextStyle(color: Global.orangepanda),

     controller: controllername,



      textAlign: align==true?TextAlign.center:TextAlign.left,



      keyboardType: TextInputType.text,

      decoration: InputDecoration(hintText: hinttext,labelStyle: TextStyle(
        color: Global.greypanda,fontSize: 12
      ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),

          borderSide:  BorderSide(color:Global.orangepanda, width: 2.0),

        ) ,

        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),

          borderSide:  BorderSide(color: Colors.grey, width: 0.0),

        ),

        // hintText: 'Enter a product name eg. pension',


        hintStyle: TextStyle(fontSize: 12,),

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(25),

          borderSide: BorderSide(

            color: Colors.red,

            style: BorderStyle.solid,

          ),

        ),

        filled: true,

        contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 10,right: 10),

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

  customraisedbutton({this.text,this.click,this.clr,this.bgclr});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(color: bgclr,shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),

    ),
      onPressed: (){click();},
      child: Padding(
        padding: const EdgeInsets.only(
            top: 17,bottom: 17
        ),
        child: Text(text,textAlign: TextAlign.center,style: TextStyle(
            color: clr,fontSize: 12,
        ),),
      ),
    );
  }
}


class customtext extends StatelessWidget {

  String text;
  customtext({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
color: Global.greypanda,fontSize: 16,
    ),);
  }
}







AppBar CustomAppbar =  AppBar(
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
            child: DropdownButton(hint: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text(""),
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
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(height: 200,width: 113,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),),
              ),
            ),
          ),

          Positioned(
              bottom: 0,
              left: 70,
              right: 30,
              child: Icon(Icons.add_circle,color: Global.orangepanda,size: 28,)
          ),
        ]
    );
  }
}

AppBar CustomAppbarforchat =  AppBar(backgroundColor: Global.whitepanda,title: Row(children: <Widget>[
  Icon(Icons.keyboard_backspace,color: Global.orangepanda,),
  Spacer(),
  Row(
    children: <Widget>[
      Container(height: 30,width: 30,margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.cover,
                image:AssetImage('assets/images/user.png'),
              )
          )
      ),
      SizedBox(width: 5,),
      Text("Ivana",style: TextStyle(color: Global.blackpanda,fontSize: 14,fontWeight: FontWeight.bold),),
    ],
  ),
  Spacer(),
  Icon(Icons.more_vert,color: Global.orangepanda,),

],),);

class customgradientbuton extends StatelessWidget {

  String buttontext;
  customgradientbuton({this.buttontext});


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Global.yellowpanda,Global.orangepanda],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            buttontext,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

AppBar CustomAppbarforsettings =
AppBar(flexibleSpace: Container(
  decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Global.yellowpanda,
            Global.orangepanda
          ])
  ),
),      backgroundColor: Global.whitepanda,title: Row(children: <Widget>[
  Container(

      decoration: BoxDecoration(color: Global.whitepanda,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),


      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.keyboard_backspace,color: Global.orangepanda,),
      )),
  Spacer(),
  Row(
    children: <Widget>[
      Container(height: 40,width: 40,margin: EdgeInsets.only(left: 20,top: 15,bottom: 10),
          decoration: new BoxDecoration(border: Border.all(color: Global.whitepanda,width: 2),
              shape: BoxShape.circle,
              image: new DecorationImage(
                fit: BoxFit.cover,
                image:AssetImage('assets/images/user.png'),
              )
          )
      ),
      SizedBox(width: 5,),
      Text("Toni",style: TextStyle(color: Global.blackpanda,fontSize: 14,fontWeight: FontWeight.bold),),
    ],
  ),
  Spacer(),
  Icon(Icons.more_vert,color: Global.orangepanda,),

],),);