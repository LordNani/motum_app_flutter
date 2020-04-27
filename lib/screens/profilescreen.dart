import 'package:Motum/models/AuthenticationEvent.dart';
import 'package:flutter/material.dart';
import 'package:Motum/models/AuthenticationBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("Logout", style: TextStyle(fontSize: 25),),
            onPressed: (){
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          ),
        ),
      ),
    );
  }
}
