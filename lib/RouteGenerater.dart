import 'package:Motum/models/UserRepository.dart';
import 'package:Motum/screens/signupscreen.dart';

import 'screens/loginscreen.dart';
import 'screens/splashscreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/signup':
        if(args is UserRepository){
          return MaterialPageRoute(builder: (_) => SignUpScreen(repository: args));
        }
      return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("Error"),
        ),
      );
    });
  }
}
