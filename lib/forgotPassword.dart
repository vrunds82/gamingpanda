import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';

import 'global.dart';

class ForgotPassword extends StatefulWidget {

  static String route = "forgot";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController email = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");

  var firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  get auth => null;

  Future<void> _handleSignIn(e) async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future <FirebaseUser> signIn(String email, String password) async {

  }






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
                Image.asset('assets/images/logo.png',height: 100,width: 100,),
                SizedBox(height: 8,),
                Text("FORGOT PASSWORD",style: TextStyle(
                    fontSize: 30,fontWeight: FontWeight.bold,color: Global.orangepanda
                ),),
                SizedBox(height: 30,),
                customtext(text: "Email"),
                SizedBox(height: 5,),
                Customtextfield(controllername: email,),

                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: customraisedbutton(click: () async {

                          if(email.text == "" )
                          {
                            Fluttertoast.showToast(
                                msg: "Email filed is required",
                                //toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                          }
                          else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email.text))
                            Fluttertoast.showToast(
                                msg: "Invalid email address.",
                                //toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );


                          else{

                            FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((value) {

                              Fluttertoast.showToast(msg: "Password reset link mailed to ${email.text}");
                            });



                          }
                          //FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                        },clr: Global.whitepanda,text: "LOGIN",bgclr: Global.orangepanda,)
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(onTap: (){
                        Navigator.of(context).pushReplacementNamed('login');
                      },
                        child: CustomText(text:"Back",
                          decoration: TextDecoration.underline,
                        ),
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
