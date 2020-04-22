import 'package:flutter/material.dart';

import 'global.dart';

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.only(left: 15,right: 15),
         child: Center(
           child: SingleChildScrollView(
             child: Column(
               children: <Widget>[
SizedBox(height: 20,),
                 Text("REGISTRATION",style: TextStyle(
                     fontSize: 30,fontWeight: FontWeight.bold,color: orangepanda
                 ),),
                 SizedBox(height: 5,),
                 CircleAvatar(
                   radius: 38,
                   child: ClipOval(
                     child: Icon(Icons.person,size: 40,)
                   ),
                 ),



                 SizedBox(height: 30,),
                 customtext(text: "Name",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: name,),
                 SizedBox(height: 20,),
                 customtext(text: "Email",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: email,),
                 SizedBox(height: 20,),
                 customtext(text: "Password",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: password,obsecuretext: true,),
                 SizedBox(height:20,),
                 customtext(text: "Confirm password",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: confirmpassword,obsecuretext: true,),
                 SizedBox(height: 20,),
                 Row(
                   children: <Widget>[
                     Expanded(
                         child: customraisedbutton(click: (){},clr: whitepanda,text: "REGISTER",)
                     ),
                   ],
                 ),
                 SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(left: 15,right: 15),
                   child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       GestureDetector(onTap: (){
                         Navigator.of(context).pushNamed('registerp');
                       },
                         child: Text("Already have Account?",style: TextStyle(
                           decoration: TextDecoration.underline,
                         )),
                       ),
                      SizedBox(width: 5,),

                       GestureDetector(onTap: (){
                         Navigator.of(context).pushNamed('login');
                       },
                         child: Text("Sign In",style: TextStyle(
                           decoration: TextDecoration.underline,fontSize: 18
                         )),
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
