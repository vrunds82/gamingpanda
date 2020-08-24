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
                        width: MediaQuery.of(context).size.width * .2,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "GET PREMIUM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Global.isSwitchedFT == true
                              ? Global.whitepanda
                              : Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .035,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "YOUR TEXT HERE YOUR TEXT HERE YOUR TEXT HERE YOUR TEXT HERE YOUR TEXT HERE YOUR TEXT HERE YOUR TEXT HERE YOUR TEXT HERE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Global.isSwitchedFT == true
                      ? Colors.white
                      : Colors.black,
                  fontSize: MediaQuery.of(context).size.width * .03,
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/tick.png",
                        width: 18,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        " HERE YOUR TEXT HERE YOUR TEXT HERE",
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
                        width: 18,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        " HERE YOUR TEXT HERE YOUR TEXT HERE",
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
                        width: 18,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        " HERE YOUR TEXT HERE YOUR TEXT HERE",
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
                    planPrice: "9.99",
                  ),
                  PremiumPriceCard(
                    onClick: (){
                      print("Card Clicked");
                    },
                    myPlan: "MONTHLY PLAN",
                    planPrice: "99.99",

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
