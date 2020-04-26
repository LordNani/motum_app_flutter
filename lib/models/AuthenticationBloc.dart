import 'dart:async';

import 'package:Motum/models/AuthenticationState.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'AuthenticationEvent.dart';
import 'UserRepository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository repository;

  AuthenticationBloc({@required this.repository}) : assert(repository != null);

  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if(event is AppStarted) {
      final bool hasToken = await repository.hasToken();

      if(hasToken){
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }

    }

    if(event is LoggedIn) {
      yield AuthLoading();
      await repository.persistToken(event.token);
      yield AuthAuthenticated();
    }

    if(event is LoggedOut) {
      yield AuthLoading();
      await repository.deleteToken();
      yield AuthUnauthenticated();
    }

  }

}