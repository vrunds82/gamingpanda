import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttery_dart2/layout.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../global.dart';
import 'matches.dart';
import 'photos.dart';
import 'profiles.dart';
import 'package:http/http.dart' as http;
class CardStack extends StatefulWidget {
  final MatchEngine matchEngine;

  CardStack({
    this.matchEngine,
  });

  @override
  _CardStackState createState() => new _CardStackState();
}

class _CardStackState extends State<CardStack> {
  Key _frontCard;
  DateMatch _currentMatch;
  double _nextCardScale = 0.9;

  @override
  void initState() {
    super.initState();
    widget.matchEngine.addListener(_onMatchEngineChange);

    _currentMatch = widget.matchEngine.currentMatch;
    _currentMatch.addListener(_onMatchChange);

    _frontCard = new Key(_currentMatch.profile.id);
  }

  @override
  void didUpdateWidget(CardStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.matchEngine != oldWidget.matchEngine) {
      oldWidget.matchEngine.removeListener(_onMatchEngineChange);
      widget.matchEngine.addListener(_onMatchEngineChange);

      if (_currentMatch != null) {
        _currentMatch.removeListener(_onMatchChange);
      }
      _currentMatch = widget.matchEngine.currentMatch;
      if (_currentMatch != null) {
        _currentMatch.addListener(_onMatchChange);
      }
    }
  }

  @override
  void dispose() {
    if (_currentMatch != null) {
      _currentMatch.removeListener(_onMatchChange);
    }

    widget.matchEngine.removeListener(_onMatchEngineChange);

    super.dispose();
  }

  void _onMatchEngineChange() {
    if (_currentMatch != null) {
      _currentMatch.removeListener(_onMatchChange);
    }
    _currentMatch = widget.matchEngine.currentMatch;
    if (_currentMatch != null) {
      _currentMatch.addListener(_onMatchChange);
    }

    _frontCard = new Key(_currentMatch.profile.name);

    setState(() {});
  }

  void _onMatchChange() {
    setState(() {

      print(_currentMatch.profile.id);

    });
  }

  Widget _buildBackCard() {
    return new Transform(
      transform: new Matrix4.identity()..scale(_nextCardScale, _nextCardScale),
      alignment: Alignment.center,
      child: new ProfileCard(
        profile: widget.matchEngine.nextMatch.profile,
      ),
    );
  }

  Widget _buildFrontCard() {
    return new ProfileCard(
      key: _frontCard,
      profile: widget.matchEngine.currentMatch.profile,
    );
  }

  SlideDirection _desiredSlideOutDirection() {
    switch (widget.matchEngine.currentMatch.decision) {
      case Decision.nope:
        return SlideDirection.left;
      case Decision.like:
        return SlideDirection.right;
      case Decision.superLike:
        return SlideDirection.up;
      default:
        return null;
    }
  }

  void _onSlideUpdate(double distance) {
    setState(() {
      _nextCardScale = 0.9 + (0.1 * (distance / 100.0)).clamp(0.0, 0.1);
    });
  }

  Future Actions(String action,String user1,String user2)
  {
/*

  http.post("http://admin.mysuitors.com/app/likedislike.php",body:{
    "user1":user1,
    "user2":user2,
    "action":action,
    "name":Globaldata.MyDetails.username
  }).then((response){
    print(response.body.toString());
  });
*/

  }


  // user defined function
 /* void _showDialog(String otherUserID,String Name,String Image) {

    if(int.parse(Globaldata.MyDetails.id)<int.parse(otherUserID))
      {
        Globaldata.ChatSelction=Globaldata.MyDetails.id+"+"+otherUserID;
      }else
        {
          Globaldata.ChatSelction=otherUserID+"+"+Globaldata.MyDetails.id;
        }
    Globaldata.ChatDisplayName=Name;
    Globaldata.UserDP=Image;
    Globaldata.other_user_id=otherUserID;


    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AnchoredOverlay(
          showOverlay: true,
          overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor)
            { return BackdropFilter(
              filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.transparent,
                child: AlertDialog(
                content: Container(
                  height: MediaQuery.of(context).size.height*.6,
                  padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                                child: Icon(Icons.cancel,color: maincolor,semanticLabel:"Invite"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),

                      Text('It\'s  a  Match',style: TextStyle(color: maincolor,fontFamily: 'Afternoon',fontSize: 25),),

                      Container(
                        height: MediaQuery.of(context).size.width*.6,
                        width: MediaQuery.of(context).size.width*.6,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/heart.gif')))
                        ,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                                NavigateToChat(
                                  otherUserID: Globaldata.other_user_id,
                                  Name: Globaldata.ChatDisplayName,
                                  Image: Globaldata.UserDP
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.chat,color: maincolor,semanticLabel: "Chat",),
                                  Text("Message",style: TextStyle(color: maincolor),)
                                ],
                              ),
                            ),
                          ),


                        ],
                      )

                    ],
                  ),
                ),

               ),
              ),
            );},
          child: Center()
        );
      },
    );
  }




 NavigateToChat({String otherUserID,String Name,String Image}){
    if(int.parse(Globaldata.MyDetails.id)<int.parse(otherUserID))
    {
      Globaldata.ChatSelction=Globaldata.MyDetails.id+"+"+otherUserID;
    }else
    {
      Globaldata.ChatSelction=otherUserID+"+"+Globaldata.MyDetails.id;
    }
    Globaldata.ChatDisplayName=Name;
    Globaldata.UserDP=Image;
    Globaldata.other_user_id=otherUserID;
    Navigator.of(context).pushNamed('firestoretest');
  }
*/
  void _onSlideOutComplete(SlideDirection direction) {
    DateMatch currentMatch = widget.matchEngine.currentMatch;

  // print(Globaldata.MyDetails.id);
    print(_currentMatch.profile.name);

    switch (direction) {
      case SlideDirection.left:
        currentMatch.nope();
        break;
      case SlideDirection.right:
        currentMatch.like();
        break;
      case SlideDirection.up:
        currentMatch.superLike();
        break;
    }

    widget.matchEngine.cycleMatch();
  }

  @override
  Widget build(BuildContext context) {
   // print('Desired slide direction ${_desiredSlideOutDirection()}');

    return new Stack(
      children: <Widget>[
        new DraggableCard(
          card: _buildBackCard(),
          isDraggable: false,
        ),
        new DraggableCard(
          card: _buildFrontCard(),
          slideTo: _desiredSlideOutDirection(),
          onSlideUpdate: _onSlideUpdate,
          onSlideOutComplete: _onSlideOutComplete,
          isDraggable: true,
        ),
      ],
    );
  }
}

enum SlideDirection {
  left,
  right,
  up,
}

class DraggableCard extends StatefulWidget {
  final Widget card;
  final bool isDraggable;
  final SlideDirection slideTo;
  final Function(double distance) onSlideUpdate;
  final Function(SlideDirection direction) onSlideOutComplete;

  DraggableCard({
    this.card,
    this.isDraggable = true,
    this.slideTo,
    this.onSlideUpdate,
    this.onSlideOutComplete,
  });

  @override
  _DraggableCardState createState() => new _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard> with TickerProviderStateMixin {
  Decision decision;
  GlobalKey profileCardKey = new GlobalKey(debugLabel: 'profile_card_key');
  Offset cardOffset = const Offset(0.0, 0.0);
  Offset dragStart;
  Offset dragPosition;
  Offset slideBackStart;
  SlideDirection slideOutDirection;
  AnimationController slideBackAnimation;
  Tween<Offset> slideOutTween;
  AnimationController slideOutAnimation;

  @override
  void initState() {
    super.initState();
    slideBackAnimation = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )
      ..addListener(() => setState(() {
            cardOffset = Offset.lerp(
              slideBackStart,
              const Offset(0.0, 0.0),
              Curves.elasticOut.transform(slideBackAnimation.value),
            );

            if (null != widget.onSlideUpdate) {
              widget.onSlideUpdate(cardOffset.distance);
            }
          }))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStart = null;
            slideBackStart = null;
            dragPosition = null;
          });
        }
      });

    slideOutAnimation = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )
      ..addListener(() {
        setState(() {
          cardOffset = slideOutTween.evaluate(slideOutAnimation);

          if (null != widget.onSlideUpdate) {
            widget.onSlideUpdate(cardOffset.distance);
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            dragStart = null;
            dragPosition = null;
            slideOutTween = null;

            if (widget.onSlideOutComplete != null) {
              widget.onSlideOutComplete(slideOutDirection);
            }
          });
        }
      });
  }

  @override
  void didUpdateWidget(DraggableCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.card.key != oldWidget.card.key) {
      cardOffset = const Offset(0.0, 0.0);
    }

    if (oldWidget.slideTo == null && widget.slideTo != null) {
      switch (widget.slideTo) {
        case SlideDirection.left:
          _slideLeft();
          break;
        case SlideDirection.right:
          _slideRight();
          break;
        case SlideDirection.up:
          _slideUp();
          break;
      }
    }
  }

  @override
  void dispose() {
    slideBackAnimation.dispose();
    super.dispose();
  }

  Offset _chooseRandomDragStart() {
    final cardContext = profileCardKey.currentContext;
    final cardTopLeft =
        (cardContext.findRenderObject() as RenderBox).localToGlobal(const Offset(0.0, 0.0));
    final dragStartY =
        Global.height * (new Random().nextDouble() < 0.5 ? 0.25 : 0.75) + cardTopLeft.dy;
    return new Offset(Global.width / 2 + cardTopLeft.dx, dragStartY);
  }

  void _slideLeft() async {
   /* final screenWidth = context.size.width;*/
    final screenWidth = Global.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween =
        new Tween(begin: const Offset(0.0, 0.0), end: new Offset(-2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  void _slideRight() async {
    /*final screenWidth = context.size.width;*/
    final screenWidth = Global.height;
    dragStart = _chooseRandomDragStart();
    slideOutTween = new Tween(begin: const Offset(0.0, 0.0), end: new Offset(2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  void _slideUp() async {
  /*  final screenHeight = context.size.height;*/
    final screenHeight = Global.height;
    dragStart = _chooseRandomDragStart();
    slideOutTween =
        new Tween(begin: const Offset(0.0, 0.0), end: new Offset(0.0, -2 * screenHeight));
    slideOutAnimation.forward(from: 0.0);
  }

  void _onPanStart(DragStartDetails details) {
    dragStart = details.globalPosition;
    print("Slide :::::::::: "+(cardOffset.dx / context.size.width).toString());


    if (slideBackAnimation.isAnimating) {
      slideBackAnimation.stop(canceled: true);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      dragPosition = details.globalPosition;
      cardOffset = dragPosition - dragStart;

      if (null != widget.onSlideUpdate) {
        widget.onSlideUpdate(cardOffset.distance);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final dragVector = cardOffset / cardOffset.distance;
    final isInLeftRegion = (cardOffset.dx / context.size.width) < -0.45;
    final isInRightRegion = (cardOffset.dx / context.size.width) > 0.45;
    final isInTopRegion = (cardOffset.dy / context.size.height) < -0.40;

    setState(() {
      if (isInLeftRegion || isInRightRegion) {
        slideOutTween = new Tween(begin: cardOffset, end: dragVector * (2 * context.size.width));
        slideOutAnimation.forward(from: 0.0);

        slideOutDirection = isInLeftRegion ? SlideDirection.left : SlideDirection.right;
      } else if (isInTopRegion) {
        slideOutTween = new Tween(begin: cardOffset, end: dragVector * (2 * context.size.height));
        slideOutAnimation.forward(from: 0.0);

        slideOutDirection = SlideDirection.up;
      } else {
        slideBackStart = cardOffset;
        slideBackAnimation.forward(from: 0.0);
      }
    });
  }

  double _rotation(Rect dragBounds) {
    if (dragStart != null) {
      final rotationCornerMultiplier =
          dragStart.dy >= dragBounds.top + (dragBounds.height / 2) ? -1 : 1;
      return (pi / 8) * (cardOffset.dx / dragBounds.width) * rotationCornerMultiplier;
    } else {
      return 0.0;
    }
  }

  Offset _rotationOrigin(Rect dragBounds) {
    if (dragStart != null) {
      return dragStart - dragBounds.topLeft;
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
 return LayoutBuilder(
   builder: (c,b){
     return new AnchoredOverlay(
       showOverlay: true,
       child: new Center(),
       overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor) {
         return CenterAbout(
           position: anchor,
           child: new Transform(
             transform: new Matrix4.translationValues(cardOffset.dx, cardOffset.dy, 0.0)
               ..rotateZ(_rotation(anchorBounds)),
             origin: _rotationOrigin(anchorBounds),
             child: LayoutBuilder(
               builder: (context,BoxCon){return  Container(
                 key: profileCardKey,
                 width: anchorBounds.width,
                 height: anchorBounds.height,
                 padding: const EdgeInsets.all(16.0),
                 child: new GestureDetector(
                   onPanStart: _onPanStart,
                   onPanUpdate: _onPanUpdate,
                   onPanEnd: _onPanEnd,
                   child: Stack(
                     children: <Widget>[
                       widget.card,
                       Center(
                         child: Opacity(
                             opacity:cardOffset.dx.abs()!=0.0?(cardOffset.dx.abs()/400)>1?1.0:cardOffset.dx.abs()/400:0.01 ,child: likedislike()) ,
                       )
                     ],
                   ),
                 ),
               );},
             ),
           ),
         );
       },
     );
   },
 );
  }


  Widget likedislike(){

    if(cardOffset.dx!=0.0)
      {
        if(cardOffset.dx>0)
          {
            return Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),

                  ),
                  Center(child: Text("Like",style: TextStyle(fontSize: 40,color: Colors.green),))
                ],
              ),
            );
          }
        else
          {
            return    Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),

                  ),
                  Center(child: Text("Dislike",style: TextStyle(fontSize: 40,color: Colors.red),))
                ],

              ),
            );
          }
      }
    else
      {
       return Text("");
      }

  }

}

class ProfileCard extends StatefulWidget {
  final Profile profile;

  ProfileCard({
    Key key,
    this.profile,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => new _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Widget _buildBackground() {
    return new PhotoBrowser(
      photoAssetPaths: widget.profile.photos,
      visiblePhotoIndex: 0,
    );
  }


  Future Actions(String action,String user1,String user2,String Title,String Content)
  {

  /*  http.post("http://admin.mysuitors.com/app/likedislike.php",body:{
      "user1":user1,
      "user2":user2,
      "action":action,
      "name":Globaldata.MyDetails.username
    }).then((response){
      print(response.body.toString());

         _showActions(content: Content,Title: Title);


    });
*/
  }

  Widget _buildProfileSynopsis() {

     return new Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Text(
                        "${widget.profile.name}  25",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      VerticalDivider(thickness: 2,color: Global.orangepanda,width: 10,),
                      Icon(MdiIcons.genderMale,color: Colors.white,)
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Image.asset("assets/images/gamegrey.png",height: 15,),
                      SizedBox(width: 10,),
                      new Text(
                        "LoL, DotA, Call of Duty 4",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Image.asset("assets/images/country.png",height: 15,),
                      SizedBox(width: 10,),
                      new Text(
                        "Croatia",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                /*GestureDetector(
                  onTap: (){
                    Actions("3",Globaldata.MyDetails.id,widget.profile.id,"HotList",widget.profile.name + " is Hot Listed" );
                  },
                  child: new Icon(
                    Icons.whatshot,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Actions("4",Globaldata.MyDetails.id,widget.profile.id,"Friend Request",widget.profile.name + " Requested for Friendship" );
                  },
                  child: new Icon(
                    Icons.supervised_user_circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Actions("5",Globaldata.MyDetails.id,widget.profile.id,"Wink","You winked "+widget.profile.name);
                  },
                  child: new Icon(
                    Icons.remove_red_eye,
                    color: Colors.white,
                  ),
                ),*/
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){


                    setState(() {

                    });

             //       _showUserDetails(widget.profile.index);
                  },
                  child: new Icon(
               Icons.info,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


/*  void _showUserDetails(String index) {
    Actions("0",Globaldata.MyDetails.id,Globaldata.otherUsers[int.parse(index)].id,"View",Globaldata.otherUsers[int.parse(index)].firstname + " Requested for Friendship" );
    print(index+" Index");
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AnchoredOverlay(
            showOverlay: true,
            overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor)
            { return BackdropFilter(
              filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SafeArea(
                child: Stack(

                  children: <Widget>[

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: AlertDialog(
                        content: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                InfoCards(Title: "Username",Description: Globaldata.otherUsers[int.parse(index)].username),
                                InfoCards(Title: "Mobile",Description: Globaldata.otherUsers[int.parse(index)].mobile),
                                InfoCards(Title: "Date of Birth",Description: Globaldata.otherUsers[int.parse(index)].dob),
                                InfoCards(Title: "Status",Description: Globaldata.otherUsers[int.parse(index)].status),
                                InfoCards(Title: "Headline",Description: Globaldata.otherUsers[int.parse(index)].headline),
                                InfoCards(Title: "First Name",Description: Globaldata.otherUsers[int.parse(index)].firstname),
                                InfoCards(Title: "Height",Description: Globaldata.otherUsers[int.parse(index)].height),
                                InfoCards(Title: "Weight",Description: Globaldata.otherUsers[int.parse(index)].weight),
                                InfoCards(Title: "BodyType",Description: Globaldata.otherUsers[int.parse(index)].bodytype),
                                InfoCards(Title: "Eye Color",Description: Globaldata.otherUsers[int.parse(index)].eyecolor),
                                InfoCards(Title: "Hair Color",Description: Globaldata.otherUsers[int.parse(index)].haircolor),
                                InfoCards(Title: "Ethinicity",Description: Globaldata.otherUsers[int.parse(index)].ethinicity),
                                InfoCards(Title: "Religion",Description: Globaldata.otherUsers[int.parse(index)].religion),
                                InfoCards(Title: "Gender",Description: Globaldata.otherUsers[int.parse(index)].gender),
                                InfoCards(Title: "Looking",Description: Globaldata.otherUsers[int.parse(index)].looking),
                                InfoCards(Title: "For Purpose",Description: Globaldata.otherUsers[int.parse(index)].for_purpose),
                                InfoCards(Title: "Occupation",Description: Globaldata.otherUsers[int.parse(index)].occupation),
                                InfoCards(Title: "Drinking",Description: Globaldata.otherUsers[int.parse(index)].drinking),
                                InfoCards(Title: "Marital Status",Description: Globaldata.otherUsers[int.parse(index)].marital),
                                InfoCards(Title: "Education",Description: Globaldata.otherUsers[int.parse(index)].education),
                                InfoCards(Title: "Childrens",Description: Globaldata.otherUsers[int.parse(index)].havechildren),
                                InfoCards(Title: "Want Childrens ?",Description: Globaldata.otherUsers[int.parse(index)].wantchildren),
                                InfoCards(Title: "Car",Description: Globaldata.otherUsers[int.parse(index)].car),
                                InfoCards(Title: "Income",Description: Globaldata.otherUsers[int.parse(index)].income),
                                InfoCards(Title: "Pet",Description: Globaldata.otherUsers[int.parse(index)].pet),
                                InfoCards(Title: "Intention",Description: Globaldata.otherUsers[int.parse(index)].intention),
                                InfoCards(Title: "About",Description: Globaldata.otherUsers[int.parse(index)].about),
                                InfoCards(Title: "Interests",Description: Globaldata.otherUsers[int.parse(index)].interests),
                                InfoCards(Title: "Smoking",Description: Globaldata.otherUsers[int.parse(index)].smoking),
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Positioned(top: 33,right: 33,child:   GestureDetector(onTap: (){Navigator.of(context).pop();},child: Icon(Icons.cancel,color: Colors.red,size: 25,),),),
                  ],
                ),
              ),
            );},
            child: Center()
        );
      },
    );
  }*/

/*  void _showActions({String content,String Title}) {


    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AnchoredOverlay(
            showOverlay: true,
            overlayBuilder: (BuildContext context, Rect anchorBounds, Offset anchor)
            { return BackdropFilter(
              filter:  ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SafeArea(
                child: Center(
                  child: Container(

                    child: AlertDialog(
                      elevation: 10,
                      shape: RoundedRectangleBorder(side: BorderSide(color: maincolor,style: BorderStyle.solid,width: 3),borderRadius: BorderRadius.all(Radius.circular(10))),
                      title: Text(Title,style: TextStyle(color: maincolor),textAlign: TextAlign.center,),
                      actions: <Widget>[
                        FlatButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: Text("Close",style: TextStyle(color: maincolor),))
                      ],
                        content: Container(

                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                              Text(content)
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ),
            );},
            child: Center()
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            color: const Color(0x11000000),
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(10.0),
        child: new Material(
          child: new Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBackground(),
              _buildProfileSynopsis(),
            ],
          ),
        ),
      ),
    );
  }
}
