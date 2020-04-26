import 'dart:html';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'LoginState.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({@required this.username, @required this.password});

  @override
  List<Object> get Props => [username,password];

  @override
  String toString() => 'Login button pressed { username : $username, password : $password}';
}
