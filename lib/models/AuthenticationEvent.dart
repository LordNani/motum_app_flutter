import 'package:Motum/models/UserRepository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
}

class LoggedIn extends AuthenticationEvent {
  final TokenPair token;

  const LoggedIn({@required this.token});

  @override
  String toString() => 'LoggedIn { token : $token';

  @override
  List<Object> get props => [token];

}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

