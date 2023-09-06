import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tic_tac_tow/main.dart';
import 'game/game_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const GameScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    font = MediaQuery.of(context).size.width / 400;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.blue,
        ),
        child: Center(
            child: Image.asset(
          'assets/tic_tac_toe.png',
          width: width * 0.5,
          height: height * 0.2,
        )),
      ),
    );
  }
}
