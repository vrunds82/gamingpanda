import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamingpanda/API_Calls/api.dart';
import 'package:gamingpanda/CardSwipe/profiles.dart';
import 'package:gamingpanda/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OtherUserProfilePage extends StatefulWidget {
  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  Profile userProfile;

  GetUserProfile() async {
    userProfile = await OtherUserDetails();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userProfile == null
          ? Center(
              child: SizedBox(
                  width: 100, height: 100, child: CircularProgressIndicator()))
          : OtherUserProfileWidget(
              UserProfile: userProfile,
            ),
    );
  }
}

class OtherUserProfileWidget extends StatefulWidget {
  Profile UserProfile;

  OtherUserProfileWidget({this.UserProfile});

  @override
  _OtherUserProfileWidgetState createState() => _OtherUserProfileWidgetState();
}

class _OtherUserProfileWidgetState extends State<OtherUserProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.isweb
            ? Colors.transparent
            : Global.isSwitchedFT == true ? Global.darkBlue : Global.whitepanda,
        brightness:
            Global.isSwitchedFT == false ? Brightness.light : Brightness.dark,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back,color:Global.isSwitchedFT == true ? Global.whitepanda : Global.blackpanda ,),
          ),
        ),
        title: Row(
          children: <Widget>[
            Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(left: 00, top: 15, bottom: 10),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: Global.OtherUserProfile.dp == null ||
                              Global.OtherUserProfile.dp == ""
                          ? AssetImage('assets/images/user.png')
                          : NetworkImage(Global.OtherUserProfile.dp),
                    ))),
            SizedBox(
              width: 10,
            ),
            CustomText(
              text: Global.OtherUserProfile.name.length > 12
                  ? Global.OtherUserProfile.name.substring(0, 12)
                  : Global.OtherUserProfile.name,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        centerTitle: true,
        /*actions: <Widget>[
          PopupMenuButton(
            color: Global.isSwitchedFT == true
                ? Global.darkBlue
                : Global.whitepanda,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: CustomText(text: "Show Profile"),
                ),
                PopupMenuItem(
                  child: CustomText(text: "Delete Conversation"),
                ),
              ];
            },
          )
        ],*/
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color:
                    Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
                child: SizedBox(
                  width: Global.width,
                  child: Column(
                    children: [
                      widget.UserProfile.photos.isNotEmpty
                          ? Container(
                              width: Global.width,
                              height: Global.width,
                              child: UserImages(
                                Images: widget.UserProfile.photos,
                              ))
                          : Container(
                              width: Global.width,
                              height: Global.width,
                              child: Global.OtherUserProfile.dp == null ||
                                      Global.OtherUserProfile.dp == ""
                                  ? Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.network(
                                      Global.OtherUserProfile.dp,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new CustomText(
                                  text:
                                      "${widget.UserProfile.name}  ${widget.UserProfile.age ?? 0}",
                                  fontSize: 18.0,
                                ),
                                VerticalDivider(
                                  thickness: 2,
                                  color: Global.orangepanda,
                                  width: 10,
                                ),
                                Icon(
                                  widget.UserProfile.gender == "Male"
                                      ? MdiIcons.genderMale
                                      : widget.UserProfile.gender != "Female"
                                          ? MdiIcons.genderTransgender
                                          : MdiIcons.genderFemale,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/images/gamegrey.png",
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                new CustomText(
                                  text: "Games : " + (widget.UserProfile.games ?? ""),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                //Flag('AD', height: 15, width: 20, fit: BoxFit.fill),
                                SizedBox(
                                  width: 10,
                                ),
                                new CustomText(
                                  text: "Country : " +
                                      (widget.UserProfile.country ?? "NA"),
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: new CustomText(
                                    text: "Description : " +
                                        (widget.UserProfile.bio ?? "NA"),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
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

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                    child: customraisedbutton(
                      click: () {
                        DeleteUserFromChat();
                      },
                      text: "DELETE",
                      clr: Global.whitepanda,
                      bgclr: Global.darkBlue,

                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: customraisedbutton(
                      click: () {},
                      text: "REPORT",
                      clr: Global.whitepanda,
                      bgclr: Global.darkBlue,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }


  DeleteUserFromChat() async {
    ProgressDialog(context);
    print("inbox/messages/"+Global.User.uid+"/"+widget.UserProfile.id);
    await Firestore.instance.collection("inbox/messages/"+Global.User.uid).document(widget.UserProfile.id).delete().catchError((error){
      print(error);
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

}

class UserImages extends StatefulWidget {
  List<String> Images;
  UserImages({this.Images});

  @override
  _UserImagesState createState() => _UserImagesState();
}

class _UserImagesState extends State<UserImages> {
  PageController controller = new PageController(initialPage: 0);
  int pagenumber=0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(

            controller: controller,
            itemCount: widget.Images.length,

            onPageChanged: (number) async {
              print("PageChanged");
              print(number);
              pagenumber=number;
              setState(() {
              });

            },
            itemBuilder: (c, i) {
              return Container(
                width: Global.width,
                height: Global.height,
                child: Image.network(
                  widget.Images[i],
                  fit: BoxFit.cover,
                ),
              );
            }),
        widget.Images.length > 1
            ? Container(
                width: Global.width,
                height: Global.width,
                child: Center(
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            print(controller.page.toInt().toString());
                            controller.previousPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn).whenComplete(() {
                              setState(() {

                                pagenumber=controller.page.toInt();

                              });

                            });

                            print("PageNUmber + $pagenumber");
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.navigate_before,
                                color: Colors.black,
                                size: 50,
                              ),
                            ),
                          )),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            print(controller.page.toInt().toString());
                            controller.nextPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn).whenComplete(() {
                              pagenumber=controller.page.toInt();
                              setState(() {

                              });

                            });

                          print("PageNUmber + $pagenumber");

                          },
                          child: Container(   color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.navigate_next,
                                color: Colors.black,
                                size: 50,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            : SizedBox(),
        Positioned.fill(top: MediaQuery.of(context).size.width-30,child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 26,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.Images.length,
                        itemBuilder: (c,i){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: pagenumber==i?Colors.white:Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          height: 10,width: 10,
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),),
          ],
        ))
      ],
    );
  }



}
