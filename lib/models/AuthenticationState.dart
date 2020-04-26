import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

//uninitialized - waiting to see if user is authenticated, on app start
class AuthUninitialized extends AuthenticationState{}
//logged in successfully
class AuthAuthenticated extends AuthenticationState{}
//failed to log in
class AuthUnauthenticated extends AuthenticationState{}
//waiting to persist or delete a token
class AuthLoading extends AuthenticationState{}

