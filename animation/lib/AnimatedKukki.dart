

import 'package:flutter/material.dart';

class AnimatedKukki extends StatefulWidget {

  String ImageFolderpath;


  AnimatedKukki({this.ImageFolderpath});

  @override
  State createState() => new AnimatedKukkiState();
}

class AnimatedKukkiState extends State<AnimatedKukki> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    _controller = new AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    _animation = new IntTween(begin: 1, end: 20).animate(_controller);
  }

  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              String frame = _animation.value.toString();
              return new Image.asset(
                '${widget.ImageFolderpath}/$frame-min.png',
                gaplessPlayback: true,
              );
            },
          ),
          new Text('Image: Guillaume Kurkdjian', style: new TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}