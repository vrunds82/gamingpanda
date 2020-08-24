import 'package:flutter/material.dart';
import 'package:gamingpanda/global.dart';

class BuyCoinsNow extends StatefulWidget {
  @override
  _BuyCoinsNowState createState() => _BuyCoinsNowState();
}

class _BuyCoinsNowState extends State<BuyCoinsNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Global.isSwitchedFT == true ? Global.blackpanda : Global.whitepanda,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  print("POP");
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/cross.png',width: MediaQuery.of(context).size.width*.04,)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HOW MANY COINS DO YOU WANT?",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color:Global.isSwitchedFT == true ? Global.whitepanda : Colors.black,fontSize: MediaQuery.of(context).size.width*.04,),)
                ],
              ),
              SizedBox(height: 10,),
              BuyCoinCards(onClick: (){
                print("Card Clicked");
              },
              image: "assets/images/coin10.png",
              //textColor: Colors.orange,
              //cardColor: Global.isSwitchedFT == true ? Colors.black : Global.whitepanda,
              coins: "10",
              price: "11",),
              BuyCoinCards(onClick: (){
                print("Card Clicked");
              },
                image: "assets/images/coin25.png",
                //textColor: Colors.orange,
                //cardColor: Global.isSwitchedFT == true ? Colors.black : Global.whitepanda,
                coins: "25",
                price: "25",),
              BuyCoinCards(onClick: (){
                print("Card Clicked");
              },
                image: "assets/images/coin60.png",
                //textColor: Colors.orange,
                //cardColor: Global.isSwitchedFT == true ? Colors.black45 : Global.whitepanda,
                coins: "60",
                price: "50",),
              BuyCoinCards(onClick: (){
                print("Card Clicked");
              },
                image: "assets/images/coin100.png",
                //textColor: Colors.orange,
                //cardColor: Global.isSwitchedFT == true ? Colors.black : Global.whitepanda,
                coins: "100",
                price: "70",),
              BuyCoinCards(onClick: (){
                print("Card Clicked");
              },
                image: "assets/images/coin100.png",
                //textColor: Colors.orange,
                //cardColor: Global.isSwitchedFT == true ? Colors.black : Global.whitepanda,
                coins: "150",
                price: "100",),



            ],
          ),
        ),
      ),
    );
  }
}
