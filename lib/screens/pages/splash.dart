import 'dart:async';

import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        Navigator.pushReplacementNamed(context, '/');
        timer.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff080010),
          image: DecorationImage(
            image: AssetImage("assets/images/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
            left: width / 28, right: width / 28, bottom: height / 42),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              textAlign: TextAlign.center,
              '"Set your heart upon your work but never on its reward." - Bhagavad Gita 2.47',
              style: TextStyle(
                color: Colors.white,
                fontSize: height / 48,
              ),
            ),
            SizedBox(
              height: height / 14,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: height / 70),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: height / 58),
            )
          ],
        ),
      ),
    );
  }
}
