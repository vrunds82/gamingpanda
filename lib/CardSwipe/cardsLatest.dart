import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttery_dart2/layout.dart';
import 'package:gamingpanda/global.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'matches.dart';
import 'photos.dart';
import 'profiles.dart';

class CardStack extends StatefulWidget {
  final MatchEngine matchEngine;
  Function Callback;

  CardStack({
    this.matchEngine,
    this.Callback
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
    setState(() {/* current match may have changed state, re-render */});
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








  /*void _onSlideOutComplete(SlideDirection direction) {
    DateMatch currentMatch = widget.matchEngine.currentMatch;


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
  }*/

  Future<void> _onSlideOutComplete(SlideDirection direction) async {
    DateMatch currentMatch = widget.matchEngine.currentMatch;

    // print(Globaldata.MyDetails.id);
    //  print(_currentMatch.profile.name);

    switch (direction) {
      case SlideDirection.left:
        ActionsToUsers(action: "dislike",user1: Global.userData.userId,user2: currentMatch.profile.id);
        currentMatch.nope();

        break;
      case SlideDirection.right:

        currentMatch.like();
        if(currentMatch.profile.liked) {
          ActionsToUsers(action: "like",
              user1: Global.userData.userId,
              user2: currentMatch.profile.id);
          CreateChat(false, currentMatch.profile);
        }

        break;
      case SlideDirection.up:

        if(currentMatch.profile.disliked==null || !currentMatch.profile.disliked) {
          ActionsToUsers(action: "superlike",
              user1: Global.userData.userId,
              user2: currentMatch.profile.id);
          CreateChat(true, currentMatch.profile);
          currentMatch.superLike();
        }else{
          currentMatch.superLike();
        }



        break;
    }

    widget.matchEngine.cycleMatch();
  }


  Future ActionsToUsers({String action,String user1,String user2})
  async {



    String URL = "";
    if(action=="like"){
      Fluttertoast.showToast(msg: "Let's play");
      URL ="${Global.BaseURL}like";
    }else if(action == "dislike"){
      Fluttertoast.showToast(msg: "Nope");
      URL ="${Global.BaseURL}dislike";
    }else if(action == "superlike"){
      Fluttertoast.showToast(msg: "Super Like");
      URL = "${Global.BaseURL}superlike";
    }
    await http.post(URL,body:{
      "fromUserId":user1,
      "toUserId":user2,
    }).then((response){
      print("Response : "+response.body.toString());
    });
  }




  CreateChat(bool SuperLike,Profile profile){
    Firestore.instance.collection('inbox/messages/${Global.User.uid}').document(profile.id).setData({
      "uid":profile.id,
      "image":profile.dp,
      "name":profile.name,
      "msg":"It's a Match",
      'time': Timestamp.now(),
    });

    Firestore.instance.collection('inbox/messages/${profile.id}').document(Global.User.uid).setData({
      "uid":Global.User.uid,
      "image":Global.userData.profilePicture,
      "name":Global.User.displayName,
      "msg":"It's a Match",
      'time': Timestamp.now(),
    });


    if(SuperLike){
      Global.OtherUserProfile = profile;
      _showDialog(profile);
      //Global.currentpageindex=2;
      //widget.Callback();
      if(Global.isweb){
       // Global.webCurrentPageIndex=1;
       // widget.Callback();

      }else
      {

       // Navigator.of(context).pushNamed('chat');
      }

    }else
    {
      print("Showing Dialog for like");
      Global.OtherUserProfile = profile;
      Global.currentpageindex=2;

      _showDialog(profile);
    }


    //Navigator.of(context).pushReplacementNamed(SuperLike?'chat':'Messages');
    //Navigator.of(context).pushNamed('chat');

  }

  void _showDialog(Profile profile) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.transparent,
                    //width: Global.isweb?MediaQuery.of(context).size.width*0.2:MediaQuery.of(context).size.width*0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          color:Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,children: [
                                  GestureDetector(onTap: (){
                                    Navigator.of(context).pop();
                                  },child: Icon(Icons.cancel,color: Global.orangepanda,size: 20,)),
                                ],),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset('assets/images/remote.png',width: Global.width*(Global.isweb?0.05:0.3),),
                                ),
                                CustomText(text:"New Connection!",color: Global.orangepanda,),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                          Global.OtherUserProfile = profile;
                                          Global.currentpageindex=2;
                                          widget.Callback();
                                          if(Global.isweb){
                                            Global.webCurrentPageIndex=1;
                                            widget.Callback();
                                            //Navigator.of(context).pushReplacementNamed('webChattingPage');
                                          }else
                                          {
                                            Navigator.of(context).pushNamed('chat');
                                          }
                                        },
                                        child: CustomText(text:"Click here to chat Now",color: Global.orangepanda,),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );},
            child: Center()
        );
      },
    );
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
    this.isDraggable,
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
      duration: const Duration(milliseconds: 500),
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
    /*final cardContext = profileCardKey.currentContext;
    final cardContext = profileCardKey.currentContext;*/
    final cardTopLeft =Offset(0.0, 0.0);
        //(cardContext.findRenderObject() as RenderBox).localToGlobal(const Offset(0.0, 0.0));
   /* final dragStartY =
        cardContext.size.height * (new Random().nextDouble() < 0.5 ? 0.25 : 0.75) + cardTopLeft.dy;
    return new Offset(cardContext.size.width / 2 + cardTopLeft.dx, dragStartY);*/

    final dragStartY =
        Global.height * (new Random().nextDouble() < 0.5 ? 0.25 : 0.75) + cardTopLeft.dy;
    return new Offset(Global.width / 2 + cardTopLeft.dx, dragStartY);

  }

  void _slideLeft() async {
    //final screenWidth = context.size.width;
    final screenWidth = Global.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween =
        new Tween(begin: const Offset(0.0, 0.0), end: new Offset(-2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);




  }

  void _slideRight() async {
    //final screenWidth = context.size.width;
    final screenWidth = Global.width;
    dragStart = _chooseRandomDragStart();
    slideOutTween = new Tween(begin: const Offset(0.0, 0.0), end: new Offset(2 * screenWidth, 0.0));
    slideOutAnimation.forward(from: 0.0);
  }

  void _slideUp() async {
    //final screenHeight = context.size.height;
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
    final isInLeftRegion = (cardOffset.dx / context.size.width) < -0.25;
    final isInRightRegion = (cardOffset.dx / context.size.width) > 0.25;
    final isInTopRegion = (cardOffset.dy / context.size.height) < -0.20;

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
            child: new Container(
              key: profileCardKey,
              width: anchorBounds.width,
              height: anchorBounds.height,
              padding: const EdgeInsets.all(16.0),
              child: new GestureDetector(
                onPanStart: widget.isDraggable==false?(details){}:_onPanStart,
                onPanUpdate: widget.isDraggable==false?(details){}:_onPanUpdate,
                onPanEnd:widget.isDraggable==false?(details){}: _onPanEnd,
                child: Stack(
                  children: <Widget>[
                    widget.card,
                    Center(
                      child: likedislike() ,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget likedislike(){




    print("DYYYYYY : "+widget.isDraggable.toString()
    );


    return Stack(
      children: [
        cardOffset.dx> (Global.isweb?150:50) && cardOffset.dy>(Global.isweb?-250:-150)?Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(),
                Text("Let's Play",style: TextStyle(fontSize: 40,color: Global.orangepanda),)
              ],

            ),
          ),
        ):SizedBox(),
        cardOffset.dx<(Global.isweb?-150:-50) && cardOffset.dy>(Global.isweb?-250:-150)?Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(),
                Text("Nope",style: TextStyle(fontSize: 40,color: Global.greypanda),)
              ],

            ),
          ),
        ):SizedBox(),
        cardOffset.dy<(Global.isweb?-250:-150) && cardOffset.dx<50 && cardOffset.dx>-50?Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
                ),
                Center(child: Text("Super Play",style: TextStyle(fontSize: 40,color: Global.SuperLikeBlue),))
              ],
            ),
          ),
        ):SizedBox(),
      ],
    );


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

  bool showDetail=true;

  Widget _buildBackground() {
    return new PhotoBrowser(
      photoAssetPaths: widget.profile.photos,
      visiblePhotoIndex: 0,
    );
  }

  Widget _buildProfileSynopsis() {

    return new Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: GestureDetector(
        onTap: (){
          showDetail=!showDetail;
          setState(() {
          });
        },
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
                          "${widget.profile.name.length>15?widget.profile.name.substring(0,14)+"...":widget.profile.name}  ${widget.profile.age}",
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize:18.0,
                          ),
                        ),
                        VerticalDivider(thickness: 2,color: Global.orangepanda,width: 10,),
                        Icon(widget.profile.gender=="Male"?MdiIcons.genderMale:widget.profile.gender!="Female"?MdiIcons.genderTransgender:MdiIcons.genderFemale,color: Colors.white,)
                      ],
                    ),
                    SizedBox(height: 5,),
                    widget.profile.games==null || widget.profile.games==""?SizedBox():Row(
                      children: <Widget>[
                         Image.asset("assets/images/gamegrey.png",height: 15,),
                        SizedBox(width: 10,),
                        new Text(
                          widget.profile.games??"",
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
              /*      Row(
                      children: <Widget>[
                        Icon(MdiIcons.server,color: Global.whitepanda,size: 20,),
                        //Flag('AD', height: 15, width: 20, fit: BoxFit.fill),
                        SizedBox(width: 10,),
                        new Text(
                          (widget.profile.server!=null && widget.profile.server!=""?  "${widget.profile.server}, ":"") ,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),*/
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_on,color: Global.whitepanda,),
                        //Flag('AD', height: 15, width: 20, fit: BoxFit.fill),
                        SizedBox(width: 10,),
                        new Text(
                          (widget.profile.server!=null && widget.profile.server!=""?  "${widget.profile.server}, ":"") +widget.profile.country??"",
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 5,),
                    showDetail?Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 50,

                            child: SingleChildScrollView(
                              child: new Text(
                                widget.profile.bio.length>40?widget.profile.bio.substring(0,40)+"...":widget.profile.bio,
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ):Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 200,

                            child: SingleChildScrollView(
                              child: new Text(
                                widget.profile.bio??"",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
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
                      showDetail=!showDetail;
                      setState(() {
                      });

                      //     Fluttertoast.showToast(msg: showDetail.toString());


                      //       _showUserDetails(widget.profile.index);
                    },
                    child: new Icon(
                      showDetail?Icons.keyboard_arrow_down:Icons.info,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  /*Widget _buildProfileSynopsis() {
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
                  new Text(
                    widget.profile.name,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  new Text(
                    widget.profile.bio,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                *//*GestureDetector(
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
                ),*//*
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){

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
