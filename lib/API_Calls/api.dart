import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:gamingpanda/website/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../Lists.dart';

GetUserDeatils() async {
  await http.post("${Global.BaseURL}profile/GetOwnUserProfile",
      body:{"UserId":Global.User.uid}).then((response){
        print(response.statusCode);

        print(response.body);
        var parsedjson=jsonDecode(response.body);
        Global.userData= UserData.fromJson(parsedjson);
        print("UserDat ${jsonEncode(Global.userData)}");

  });

  //await getSuperPlay();

}


getTotalUsers() async {
  await http.get("${Global.BaseURL}UserCount").then((value){

    print(value.body);

    if(value.body!=null && value.body!="") {

       var parsedData = jsonDecode(value.body);

    if(parsedData['message']!=null){
      Global.noOfUsers = int.parse(parsedData['message']);
    }
    }
  });
}


getSuperPlay() async {
  await http.post("${Global.BaseURL}profile/SuperPanda",body: {
    "UserId":Global.userData.userId
  }).then((value){

    print(value.body);

    if(value.body!=null && value.body!="") {

      var parsedData = jsonDecode(value.body);

      if(parsedData['message']!=null && parsedData['type']!="Error"){
        Global.superPlay = int.parse(parsedData['message']);
      }
    }
  });
}

reduceSuperPlay() async {
  await http.post("${Global.BaseURL}profile/SuperPandaReduce",body: {
    "UserId":Global.userData.userId
  }).then((value){

    print(value.body);

    if(value.body!=null && value.body!="") {

      var parsedData = jsonDecode(value.body);

      if(parsedData['message']!=null && parsedData['type']!="Error"){
        Global.superPlay = int.parse(parsedData['message']);
      }
    }


  });
}



UpdateTokenWeb() async {


  /*final _messaging = FBMessaging.instance;
  _messaging.requestPermission().then((_) async {
    final _token = await _messaging.getToken();
    Global.token = _token;
    print('Token: $_token');
  });*/

  await http.post("${Global.BaseURL}profile/token",
      body:{"Token":Global.token??"","UserID":Global.User.uid}).then((response){});
}

UpdateToken() async {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
 await firebaseMessaging.getToken().then((value) async {

   if(value!=null) {
     Global.token = value;

     print("TOKEN : " + Global.token);
     await http.post("${Global.BaseURL}profile/token",
         body:{"Token":Global.token??"","UserID":Global.User.uid}).then((response){

           print("TOKEN UPDATED");
           print(response.body);
           print("TOKEN UPDATED");

     });
   }

  });


}

Future<Profile> OtherUserDetails() async {
  Profile UserProfile = null;
  UserData OtherUserProfile ;
  String games;

  print("Getting UserDetails of : ${Global.OtherUserProfile.id}");

  await http.post("${Global.BaseURL}profile/otherUser",
      body: {"UserId":Global.OtherUserProfile.id}).then((value) {

    OtherUserProfile = UserData.fromJson(jsonDecode(value.body));
  });

  print(jsonEncode(OtherUserProfile));


  if(OtherUserProfile.game1!=null && OtherUserProfile.game1!="" && Games.indexOf(OtherUserProfile.game1)!=-1 ){
    games = ShortName[Games.indexOf(OtherUserProfile.game1)];

  }
  if(OtherUserProfile.game1!=null && OtherUserProfile.game2!="" && Games.indexOf(OtherUserProfile.game2)!=-1){
    if(games==""){
      games = ShortName[Games.indexOf(OtherUserProfile.game2)];
    }else{
      games +=","+ ShortName[Games.indexOf(OtherUserProfile.game2)];
    }
  }

  List<String> pics = new List();
  if (OtherUserProfile.profilePicture != "" && OtherUserProfile.profilePicture != "null" && OtherUserProfile.profilePicture != null) {
    pics.add(OtherUserProfile.profilePicture);
  }
  if (OtherUserProfile.image1 != "" && OtherUserProfile.image1 != "null") {
    pics.add(OtherUserProfile.image1);
  }
  if (OtherUserProfile.image2 != "" && OtherUserProfile.image2 != "null") {
    pics.add(OtherUserProfile.image2);
  }
  if (OtherUserProfile.image3 != "" && OtherUserProfile.image3 != "null") {
    pics.add(OtherUserProfile.image3);
  }
  if (OtherUserProfile.image4 != "" && OtherUserProfile.image4 != "null") {
    pics.add(OtherUserProfile.image4);
  }
  if (OtherUserProfile.image5 != "" && OtherUserProfile.image5 != "null") {
    pics.add(OtherUserProfile.image5);
  }
  if (OtherUserProfile.image6 != "" && OtherUserProfile.image6 != "null") {
    pics.add(OtherUserProfile.image6);
  }

  UserProfile= Profile(bio: OtherUserProfile.aboutUs,
      name: OtherUserProfile.userName,
      photos: pics,
      id: OtherUserProfile.userId,
      dp: OtherUserProfile.profilePicture,
      age: (DateTime.now().year-OtherUserProfile.year).toString(),
      country: OtherUserProfile.country,
      games: games,
      gender: OtherUserProfile.gender
  );
  print(jsonEncode(UserProfile));

  return UserProfile;

}