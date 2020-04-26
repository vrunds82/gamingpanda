import 'package:flutter/material.dart';


class Global{

  static bool isSwitchedFT = false;
  static double fontsize=10;
}


const orangepanda = Color(0xffFF781E);
const whitepanda = Color(0xffF8F8F8);
const greypanda = Color(0xff9A9A9A);
const greypandaicon = Color(0xffDBD8D5);
const blackpanda = Color(0xff252531);
const lightorangepanda = Color(0xffFE9335);
const darkgrey = Color(0xff9F9F9F);




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
     style: TextStyle(color: orangepanda),

     controller: controllername,



      textAlign: align==true?TextAlign.center:TextAlign.left,



      keyboardType: TextInputType.text,

      decoration: InputDecoration(hintText: hinttext,labelStyle: TextStyle(
        color: greypanda,fontSize: 12
      ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),

          borderSide:  BorderSide(color:orangepanda, width: 2.0),

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

        contentPadding: EdgeInsets.all(16),

        fillColor: Colors.white,

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
color: greypanda,fontSize: 16,
    ),);
  }
}







AppBar CustomAppbar =  AppBar(backgroundColor: whitepanda,title: Row(children: <Widget>[
  Image.asset('assets/images/usergrey.png',height: 20,width: 20,),
  Spacer(),
  Image.asset('assets/images/pandagrey.png',height: 20,width: 20,),
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
          color: greypandaicon,

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
              child: Icon(Icons.add_circle,color: orangepanda,size: 28,)
          ),
        ]
    );
  }
}
