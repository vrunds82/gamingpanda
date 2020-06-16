import 'dart:convert';

import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:http/http.dart' as http;

import '../Lists.dart';

GetUserDeatils() async {
  await http.post("${Global.BaseURL}profile/GetOwnUserProfile",
      body:{"UserId":Global.User.uid}).then((response){

        print(response.body);

        var parsedjson=jsonDecode(response.body);
        Global.userData= UserData.fromJson(parsedjson);

        print("UserDat ${jsonEncode(Global.userData)}");

  });
}

UpdateToken() async {
  await http.post("${Global.BaseURL}profile/token",
      body:{"Token":Global.token??"","UserID":Global.userData.userId}).then((response){});
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