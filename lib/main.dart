import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maple/boy.dart';
import 'package:maple/teddy.dart';
import 'package:maple/button.dart';
import 'package:maple/snail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Maple',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int snailSpriteCount = 1;
  double snailPosX = 0.5;
  String snailDirection = 'left';

  int teddySpriteCount = 1;
  double teddyPosX = 0;
  String teddyDirection = 'right';

  int boySpriteCount = 1;
  double boyPosX = -0.5;
  String boyDirection = 'right';

  Color loadingScreenColor = Colors.pink;
  Color loadingTextColor = Colors.black;
  int loadingTime = 3;

  int attackBoySpriteCount = 0;

  startGameTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        loadingTime--;
      });
      if (loadingTime == 0) {
        loadingScreenColor = Colors.transparent;
        loadingTextColor = Colors.transparent;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          attack();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue.shade300,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment(snailPosX, 1),
                      child: BlueSnail(snailSpriteCount, snailDirection),
                    ),
                    Container(
                      alignment: Alignment(teddyPosX, 1),
                      child: MyTeddy(teddySpriteCount, teddyDirection),
                    ),
                    Container(
                      alignment: Alignment(boyPosX, 1),
                      child: MyBoy(
                          boySpriteCount, boyDirection, attackBoySpriteCount),
                    ),
                    Container(
                      color: loadingScreenColor,
                      child: Center(
                        child: Text(
                          loadingTime.toString(),
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: loadingTextColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(height: 10, color: Colors.green.shade600),
            Expanded(
              child: Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    const Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "메이플",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                              child:
                                  MyButton(text: "PLAY", function: startGame)),
                          Expanded(
                              child:
                                  MyButton(text: "ATTACK", function: attack)),
                          Expanded(
                              child: MyButton(text: "←", function: moveLeft)),
                          Expanded(
                              child: MyButton(text: "↑", function: moveJump)),
                          Expanded(
                              child: MyButton(text: "→", function: moveRight)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startGame() {
    startGameTimer();
    moveSnail();
    moveTeddy();
    moveBoy();
  }

  attack() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        attackBoySpriteCount++;
      });
      if (attackBoySpriteCount == 5) {
        if (boyDirection == 'right' && boyPosX + 0.2 > snailPosX) {
          print('hit');
        } else {
          print('missed');
        }
        attackBoySpriteCount = 0;
        timer.cancel();
      }
    });
  }

  moveSnail() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        snailSpriteCount++;
        if (snailDirection == 'left') {
          snailPosX -= 0.01;
        } else {
          snailPosX += 0.01;
        }

        if (snailPosX < 0.3) {
          snailDirection = 'right';
        } else if (snailPosX > 0.6) {
          snailDirection = 'left';
        }

        if (snailSpriteCount == 5) {
          snailSpriteCount = 1;
        }
      });
    });
  }

  moveTeddy() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        teddySpriteCount++;

        if (teddySpriteCount == 9) {
          teddySpriteCount = 1;
        }
        if ((teddyPosX - boyPosX).abs() > 0.2) {
          if (boyDirection == 'right') {
            teddyPosX = boyPosX - 0.2;
          } else if (boyDirection == 'left') {
            teddyPosX = boyPosX + 0.2;
          }
        }

        if (teddyPosX - boyPosX > 0) {
          teddyDirection = 'left';
        } else {
          teddyDirection = 'right';
        }
      });
    });
  }

  moveBoy() {
    Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        if (boySpriteCount >= 12) {
          boySpriteCount = 1;
        } else {
          boySpriteCount++;
        }
      });
    });
  }

  moveLeft() {
    setState(() {
      boyPosX -= 0.03;
      if (boySpriteCount >= 12) {
        boySpriteCount = 1;
      } else {
        boySpriteCount++;
      }
      boyDirection = 'left';
    });
  }

  moveRight() {
    setState(() {
      boyPosX += 0.03;
      if (boySpriteCount >= 12) {
        boySpriteCount = 1;
      } else {
        boySpriteCount++;
      }
      boyDirection = 'right';
    });
  }

  moveJump() {}
}
