import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage('assets/images/MotumLogo.png'),fit: BoxFit.contain,),
    );
  }
}
