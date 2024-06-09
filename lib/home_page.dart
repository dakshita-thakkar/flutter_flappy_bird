
import 'package:flappy_birrd/barrier.dart';
import 'package:flappy_birrd/bird.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 2;
  double birdWidth = 0.1;
  double birdHeight = 0.12;

  bool gameHasStarted = false;

  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      // Check if the bird is dead
      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      moveMap();
      time += 0.05; // Adjust the time increment for smoother movement
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context); // To dismiss the alert dialog
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      height = birdY;
      barrierX = [2, 2 + 1.5]; // Reset barrier positions
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 217, 144, 231),
            title: const Center(
                child: Text(
              'G A M E  O V E R',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: const Text(
                        'PLAY AGAIN',
                        style: TextStyle(color: Colors.brown),
                      )),
                ),
              )
            ],
          );
        });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.05;
      });

      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF87CEFA),
                  Color.fromARGB(255, 173, 196, 214),
                  Color(0xFF00BFFF)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),
                      MyBarrier(
                          barrierHeight: barrierHeight[0][0],
                          barrierWidth: barrierWidth,
                          isThisBottomBarrier: false,
                          barrierX: barrierX[0]),
                      MyBarrier(
                          barrierHeight: barrierHeight[0][1],
                          barrierWidth: barrierWidth,
                          isThisBottomBarrier: true,
                          barrierX: barrierX[0]),
                      MyBarrier(
                          barrierHeight: barrierHeight[1][0],
                          barrierWidth: barrierWidth,
                          isThisBottomBarrier: false,
                          barrierX: barrierX[1]),
                      MyBarrier(
                          barrierHeight: barrierHeight[1][1],
                          barrierWidth: barrierWidth,
                          isThisBottomBarrier: true,
                          barrierX: barrierX[1]),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: Text(
                          gameHasStarted ? '' : 'T A P   T O  P L A Y',
                          style:
                              const TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 189, 225, 110),
                  Color.fromARGB(255, 131, 209, 68),
                  Color(0xFF33691E)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
