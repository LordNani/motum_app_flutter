import 'package:Motum/models/AuthenticationBloc.dart';
import 'package:Motum/models/AuthenticationEvent.dart';
import 'package:Motum/models/AuthenticationState.dart';
import 'package:Motum/models/UserRepository.dart';
import 'package:Motum/screens/loginscreen.dart';
import 'package:Motum/screens/profilescreen.dart';
import 'package:Motum/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:Motum/RouteGenerater.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//
//      title: 'MOTUM',
//      theme: ThemeData(
//          floatingActionButtonTheme: FloatingActionButtonThemeData(
//              backgroundColor: Color(0xF85C26FF)),
//      fontFamily: 'Ubuntu',),
//
//      //TODO Theme in separate folder and file style.dart
//      initialRoute: '/',
//      onGenerateRoute: RouteGenerator.generateRoute,
//    );
//  }
//}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(repository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOTUM',
      theme: ThemeData(
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xF85C26FF)),
        fontFamily: 'Ubuntu',
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthUninitialized) {
            return SplashScreen();
          }
          if (state is AuthAuthenticated) {
            return ProfileScreen();
          }
          if (state is AuthUnauthenticated) {
            return LoginScreen(repository: userRepository);
          }
          if (state is AuthLoading) {
            return LoadingIndicator();
          }
          return Container();
        },
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(),
      );
}
