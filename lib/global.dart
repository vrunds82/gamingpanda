import 'package:flutter/material.dart';


class Global{

  static bool isSwitchedFT = false;
}


const orangepanda = Color(0xffFF781E);
const whitepanda = Color(0xffF8F8F8);
const greypanda = Color(0xff9A9A9A);

class Customtextfield extends StatelessWidget {

TextEditingController controllername = TextEditingController();



bool obsecuretext;
  Customtextfield({this.controllername,this.obsecuretext});


  @override
  Widget build(BuildContext context) {
    return TextField(obscureText: obsecuretext??false,
     style: TextStyle(color: orangepanda),

     controller: controllername,



      textAlign: TextAlign.center,



      keyboardType: TextInputType.text,

      decoration: InputDecoration(
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),

          borderSide:  BorderSide(color:orangepanda, width: 2.0),

        ) ,

        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),

          borderSide:  BorderSide(color: Colors.grey, width: 0.0),

        ),

        // hintText: 'Enter a product name eg. pension',

        hintStyle: TextStyle(fontSize: 16),

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
  VoidCallback click;

  customraisedbutton({this.text,this.click,this.clr});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(color: orangepanda,shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(30.0),

    ),
      onPressed: (){click();},
      child: Padding(
        padding: const EdgeInsets.only(
            top: 17,bottom: 17
        ),
        child: Text(text,textAlign: TextAlign.center,style: TextStyle(
            color: clr,fontSize: 18,
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
