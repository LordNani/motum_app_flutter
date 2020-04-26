import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
          child: Image(
        image: AssetImage('assets/images/MotumLogo.png'),
        fit: BoxFit.scaleDown,
      )),
    );
  }
}
