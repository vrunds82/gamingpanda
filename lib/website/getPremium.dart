import 'package:flutter/material.dart';
import 'package:gamingpanda/global.dart';

class GetPremium extends StatefulWidget {
  @override
  _GetPremiumState createState() => _GetPremiumState();
}

class _GetPremiumState extends State<GetPremium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            children: [
              //Back Button
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      print("POP");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/cross.png',
                          width: MediaQuery.of(context).size.width * .04,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/medal.png",
                        width: MediaQuery.of(context).size.width * .25,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Global.orangepanda,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        //color: Global.orangepanda,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 2.0,
                              top: 2.0),
                          child: Text(
                            "GO PREMIUM",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "EVERYDAY BONUS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Global.isSwitchedFT == true
                              ? Global.whitepanda
                              : Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .025,
                        ),
                      )
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(""),
                  CustomProfileRoundButton(
                    onClick: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>BoostDialogBox(
                        icon: "assets/images/superLike.png",
                        iconColor: Global.SuperLikeBlue,
                        lowerText: "WITH SUPER LIKES SEND DIRECT MESSAGES TO ANYONE",
                        totalCoin: "5000",
                        upperText: "CONVERT PANDA COINS INTO SUPERLIKES",
                      )
                    );
                    print(" Like Button Clicked");

                  },
                    img: "assets/images/superLike.png",
                    myText: "4 Super Likes",
                  ),
                  CustomProfileRoundButton( onClick: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>BoostDialogBox(
                          icon: "assets/images/boostIcon.png",
                          iconColor: Global.orangepanda,
                          lowerText: "USE BOOST AND BECOME TOP PROFILE FOR NEXT 60 MINUTES!",
                          totalCoin: "5000",
                          upperText: "CONVERT PANDA COINS INTO BOOST",
                        )
                    );
                    print(" Like Button Clicked");

                  },
                    img: "assets/images/boostIcon.png",
                    myText: "4 Boost",
                  ),
                  CustomProfileRoundButton(onClick: (){
                    print(" Like Button Clicked");
                    Navigator.of(context).pushNamed('BuyCoinsNow');
                  },
                    img: "assets/images/pandaCoins.png",
                    myText: "7 Panda Coins",
                  ),
                  Text(""),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick.png",
                            width: 15,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            " Unlimited Swiping",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Global.isSwitchedFT == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: MediaQuery.of(context).size.width * .03,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick.png",
                            width: 15,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            " Unlock Return Button",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Global.isSwitchedFT == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: MediaQuery.of(context).size.width * .03,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick.png",
                            width: 15,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            " Remove Ads",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Global.isSwitchedFT == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: MediaQuery.of(context).size.width * .03,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick.png",
                            width: 15,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            "Unlock All Filters",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Global.isSwitchedFT == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: MediaQuery.of(context).size.width * .03,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick.png",
                            width: 15,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            "Send Gifs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Global.isSwitchedFT == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: MediaQuery.of(context).size.width * .03,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/tick.png",
                            width: 15,
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            "Amazing Experience",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Global.isSwitchedFT == true
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: MediaQuery.of(context).size.width * .03,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                " Choose A Plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Global.isSwitchedFT == true
                      ? Colors.white
                      : Colors.black,
                  fontSize: MediaQuery.of(context).size.width * .03,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PremiumPriceCard(
                    onClick: (){
                      print("Card Clicked");
                    },
                    myPlan: "MONTHLY PLAN",
                    planPrice: "7",
                    discountText: "REGULAR",
                  ),
                  PremiumPriceCard(
                    onClick: (){
                      print("Card Clicked");
                    },
                    myPlan: "6 MONTHLY PLAN",
                    planPrice: "5",
                    discountText: "28.57% OFF",
                  ),
                  PremiumPriceCard(
                    onClick: (){
                      print("Card Clicked");
                    },
                    myPlan: "ANNUAL PLAN",
                    planPrice: "4",
                    discountText: "42.85% OFF",

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
