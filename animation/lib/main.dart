import 'package:animation/AnimatedKukki.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.dark(),
      home: new MyApplication(),
    );
  }
}

class MyApplication extends StatefulWidget {
  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {

  Widget kikki;

  Apple(){
   kikki= AnimatedKukki();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kikki??Text("No Data"),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Apple();
        print("SErtadsfasdf arew");
        setState(() {

      });},),
    )
    ;
  }
}



