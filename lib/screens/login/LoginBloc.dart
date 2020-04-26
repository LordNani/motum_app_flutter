import 'dart:async';
import 'package:Motum/models/AuthenticationBloc.dart';
import 'package:Motum/models/AuthenticationEvent.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'LoginState.dart';
import 'LoginEvent.dart';
import 'package:Motum/models/UserRepository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository repository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.repository, @required this.authenticationBloc})
      : assert (repository != null),
        assert (authenticationBloc != null);

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginButtonPressed){
      yield LoginLoading();

      try {
        final token = await repository.authenticate(username: event.username, password: event.password);

        authenticationBloc.add(LoggedIn(token : token));
        yield LoginInitial();
      } catch(error){
        yield LoginFailure(error: error.toString());
      }
    }
  }

}