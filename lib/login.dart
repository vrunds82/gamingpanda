import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:
      Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,

body: Center(
  child:   Padding(
    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1),
    child: SingleChildScrollView(

      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20,),
          Image.asset('assets/images/Logo.png',height: 100,width: 100,),
          SizedBox(height: 8,),
          Text("LOGIN",style: TextStyle(
            fontSize: 30,fontWeight: FontWeight.bold,color: Global.orangepanda
          ),),
          SizedBox(height: 30,),

          customtext(text: "Email"),
          SizedBox(height: 5,),
          Customtextfield(controllername: email,),
          SizedBox(height: 20,),
          customtext(text: "Password"),
          SizedBox(height: 5,),
          Customtextfield(controllername: password,obsecuretext: true,),
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
              Expanded(
                child: customraisedbutton(click: (){},clr: Global.whitepanda,text: "LOGIN",bgclr: Global.orangepanda,)
              ),
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Row(
              children: <Widget>[
                GestureDetector(onTap: (){
                  Navigator.of(context).pushNamed('registerp');
                },
                  child: CustomText(text:"Create an Account",
              decoration: TextDecoration.underline,
            ),
                ),
                Spacer(),
                CustomText(text: "Forgot Password?",decoration: TextDecoration.underline,
                ),

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top:20,bottom: 20),
            child: CustomText(text: "OR",fontSize: 17,fontWeight: FontWeight.bold,),


          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Card(elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/g2.png',height: 25,width: 25,),
                    )
                ),
              ],
            ),
          ),
        ],

      ),

    ),

  ),
),
    );
  }
}
