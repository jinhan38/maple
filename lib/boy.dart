import 'dart:math';

import 'package:flutter/material.dart';
class MyBoy extends StatelessWidget {

  final int boySpriteCount;
  final String boyDirection;
  final int attackSpriteCount;


  MyBoy(this.boySpriteCount, this.boyDirection, this.attackSpriteCount);

  @override
  Widget build(BuildContext context) {
    String imagePath ="";
    if(attackSpriteCount > 0){
      imagePath = 'assets/images/attack/attack$attackSpriteCount.png';
    }else{
      imagePath = 'assets/images/boy/boy$boySpriteCount.png';
    }
    if (boyDirection == 'left') {
      return Container(
        alignment: Alignment.bottomCenter,
        height: 50,
        width: 50,
        child: Image.asset(imagePath),
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 50,
          width: 50,
          child: Image.asset(imagePath),
        ),
      );
    }
  }
}
