import 'dart:convert';

import 'package:gamingpanda/global.dart';
import 'package:gamingpanda/models/UserData.dart';
import 'package:http/http.dart' as http;



GetUserDeatils() async {
  await http.post("https://pandaweb20200510045646.azurewebsites.net/api/Panda/profile/GetOwnUserProfile",
      body:{"UserId":Global.User.uid}).then((response){
        var parsedjson=jsonDecode(response.body);
        Global.userData= UserData.fromJson(parsedjson);

        print("UserDat ${jsonEncode(Global.userData)}");

  });
}