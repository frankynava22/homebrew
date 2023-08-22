import 'package:flutter/material.dart';
import 'dart:async';
import 'choose_device_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, navigateToDeviceScreen);
  }

  navigateToDeviceScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChooseDeviceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4C748B), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "HOMEBREW",
              style: TextStyle(
                fontFamily: 'Norwester',
                fontWeight: FontWeight.normal,
                fontSize: 48,
                color: Color(0xFFFFFFFF), // Text color
              ),
            ),
            Text(
              "Great Coffee at Home",
              style: TextStyle(
                fontFamily: 'Kollektif',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Color(0xFFFFFFFF), // Text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
