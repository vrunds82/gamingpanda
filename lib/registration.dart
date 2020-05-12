import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

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

  checkpassword(){

    if(password.text == confirmpassword.text)
    {
      Navigator.of(context).pushNamed('cardswipe');
    }
    else
      {
        Fluttertoast.showToast(
            msg: "Password not mached",
            //toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

  }

  final _formKey = GlobalKey<FormState>();

  Signup() async {


    await http.post("https://pandaweb20200510045646.azurewebsites.net/api/panda/register?=&=&=", body: {
      "UserId": 1,
      "UserName": name.text.toString(),
      "Password": password.text.toString().trim(),
      "Email": email.text.toString(),

    }).then((response) {

      print(response.body.toString());

      var statuss = jsonDecode(response.body);
      print("result from Server : "+statuss['status'].toString());


    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
       body: Padding(
         padding: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1),
         child: Center(
           child: SingleChildScrollView(
             child: Column(

               children: <Widget>[
                SizedBox(height: 20,),
                 Text("REGISTRATION",style: TextStyle(
                     fontSize: 30,fontWeight: FontWeight.bold,color: Global.orangepanda
                 ),),
                 SizedBox(height: 15,),
                 CircleAvatar(
                   radius: 38,
                   child: ClipOval(
                     child: Icon(Icons.person,size: 40,)
                   ),
                 ),



                 SizedBox(height: 10,),
                 CustomText(text: "Name",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: name,focusborder: true,),
                 SizedBox(height: 20,),
                 CustomText(text: "Email",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: email,focusborder: true,),
                 SizedBox(height: 20,),
                 CustomText(text: "Password",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: password,obsecuretext: true,focusborder: true,),
                 SizedBox(height:20,),
                 CustomText(text: "Confirm password",),
                 SizedBox(height: 5,),
                 Customtextfield(controllername: confirmpassword,obsecuretext: true,focusborder: true,),
                 SizedBox(height: 20,),
                 Row(
                   children: <Widget>[
                     Expanded(
                         child: customraisedbutton(click: (){

                           setState(() {

                             if(name.text == "" )
                             {
                               Fluttertoast.showToast(
                                   msg: "Name filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );

                             }
                             else if (email.text == "")
                               Fluttertoast.showToast(
                                   msg: "Email filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );

                             else if (password.text == "")
                               Fluttertoast.showToast(
                                   msg: "password filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             else if (confirmpassword.text == "")
                               Fluttertoast.showToast(
                                   msg: "Confirmpassword filed is required",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );
                             else if (password.text != confirmpassword.text)
                               Fluttertoast.showToast(
                                   msg: "Password not matched",
                                   //toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.CENTER,
                                   timeInSecForIosWeb: 1,
                                   backgroundColor: Colors.red,
                                   textColor: Colors.white,
                                   fontSize: 16.0
                               );

                             else{
                               Navigator.of(context).pushNamed('cardswipe');

                             }
                           });

                           var result;
                           FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password:password.text).
                           then(result);
                           FirebaseUser user = result.user;
                           print("user id is "+ user.uid) ;

                           Signup();

                         },clr: Global.whitepanda,text: "REGISTER",bgclr: Global.orangepanda,)
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
                         child: CustomText(text:"Already have Account?"),
                       ),
                      SizedBox(width: 5,),

                       GestureDetector(onTap: (){
                         Navigator.of(context).pushNamed('login');
                       },
                         child: CustomText(text:"Sign In",
                           fontSize: 18
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





