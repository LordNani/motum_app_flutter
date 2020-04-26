import 'package:flutter/material.dart';
import 'package:Motum/RouteGenerater.dart';
import 'screens//loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'MOTUM',
      theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0xF85C26FF)),
      fontFamily: 'Ubuntu',),

      //TODO Theme in separate folder and file style.dart
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
