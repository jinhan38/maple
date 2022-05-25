import 'dart:math';

import 'package:flutter/material.dart';
class MyTeddy extends StatelessWidget {

  final int teddySpriteCount;
  final String teddyDirection;


  MyTeddy(this.teddySpriteCount, this.teddyDirection);

  @override
  Widget build(BuildContext context) {
    if (teddyDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset('assets/images/teddy/teddy$teddySpriteCount.png'),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset('assets/images/teddy/teddy$teddySpriteCount.png'),
        ),
      );
    }
  }
}
