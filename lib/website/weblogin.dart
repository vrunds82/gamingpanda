import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/global.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';


class webloginpage extends StatefulWidget {
  @override
  _webloginpageState createState() => _webloginpageState();
}

class _webloginpageState extends State<webloginpage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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

  Future <User> signIn(String email, String password) async {

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: Center(
        child:   SizedBox(
          width: Global.webwidth*.4,
          child: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1),
            child: SingleChildScrollView(

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20,),
                  Image.asset('assets/images/logo.png',height: 100,width: 100,),
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
                  Customtextfield(controllername: password,obsecuretext: true,
                  onsubmit:(apple){
                    Login();
                  } ,),
                  SizedBox(height: 20,),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: customraisedbutton(click: () async {


                            Login();



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
                          Navigator.of(context).pushReplacementNamed('webRegistration');
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
                        GestureDetector(onTap: () async {
                          final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
                          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                          final AuthCredential credential =await GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken, );
                          print(credential);
                          await FirebaseAuth.instance.signInWithCredential(credential).then((result) async {

                            if(result.user!=null){
                              Global.firebaseUser=result.user;
                              await GetUserDeatils();
                              await UpdateToken();

                              Navigator.of(context).pushReplacementNamed('webHome');
                            }

                          });
                        },
                          child: Card(elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/images/g2.png',height: 25,width: 25,),
                              )
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
      ),
    );
  }


  Login() async {

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
    else if (password.text == "")
      Fluttertoast.showToast(
          msg: "Password filed is required",
          //toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    else{
      String login;

      ProgressDialog(context);

      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email.text.replaceAll(" ", "").toLowerCase()).then((value) {
        login=value[0];
      }).catchError((onError){
        print("Error in finding values");
      });


      if(login!=null && login=="password"){

        print(login);
        print(email.text.replaceAll(" ", ""));
        print(password.text.replaceAll(" ", ""));


        FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.replaceAll(" ", "").toLowerCase(),
            password: password.text)
            .then((user) async {

          print(user);

          if(user.user!=null)
          {

            print("User ");
            print(user.user.uid);


            Global.firebaseUser=user.user;
            //  await UpdateTokenWeb();
            await GetUserDeatils();
            Navigator.of(context).pushReplacementNamed('webHome');
          }
        }).catchError((error){
          print("Current Error");
          print(error);

          Fluttertoast.showToast(msg:error.toString()+"Invalid Email or Password",backgroundColor: Colors.red,toastLength: Toast.LENGTH_LONG,);
          Navigator.of(context).pop();
          // Navigator.pop(context);
        });
      }else
      {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Please use Google SingIn",
            //toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }


    }


  }


}
