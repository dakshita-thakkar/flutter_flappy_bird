import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;

  const MyBarrier(
      {super.key,
      required this.barrierHeight,
      required this.barrierWidth,
      required this.isThisBottomBarrier,
      required this.barrierX});

  @override
  Widget build(context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
          color: Colors.green,
          height:
              MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
          width: MediaQuery.of(context).size.width * barrierWidth / 2
          ),
    );
  }
}


// 