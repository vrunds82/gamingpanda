import 'package:fluttertoast/fluttertoast.dart';

class CustomToast{


  static comingSoon({String msg}){
    Fluttertoast.showToast(msg: msg??"Comming Soon");
  }

}