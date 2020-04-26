
import 'package:Motum/models/UserRepository.dart';
import 'package:Motum/screens/login/LoginBloc.dart';
import 'package:Motum/screens/login/LoginEvent.dart';
import 'package:Motum/screens/login/LoginState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color _orangeColor = Color.fromRGBO(248, 92, 38, 1);
  final UserRepository repository;

  _LoginScreenState(this.repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xFDFDFBFF),
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: 15,
                    right: 15),
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/MotumLogo.png'),
                ),
              ),
              Text("Вход",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(30, 31, 32, 1.0),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: _orangeColor,
                                fontSize: 15,
                                letterSpacing: 0.15,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          thickness: 4,
                          color: Color.fromRGBO(30, 31, 32, 1),
                        ),
                      ),
                      Text(
                        " or login using ",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                            fontFamily: 'Ubuntu',
                            fontSize: 16),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 4,
                          color: Color.fromRGBO(30, 31, 32, 1),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Color _orangeColor = Color.fromRGBO(248, 92, 38, 1);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
        return Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 0, right: 30, left: 30),
            child: TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              style: TextStyle(fontFamily: "Roboto", fontSize: 20),
              decoration: InputDecoration(
                labelText: "Login",
                contentPadding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(218, 218, 218, 1), width: 2)),
                labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: _orangeColor, width: 2)),
              ),
            ),
          ),
          //PASSWORD
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 0, right: 30, left: 30),
            child: TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: TextStyle(fontFamily: "Roboto", fontSize: 20),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: _showPassword,
                  child: Icon(_obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
                labelText: "Password",
                contentPadding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(218, 218, 218, 1), width: 2)),
                labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: _orangeColor, width: 2)),
              ),
            ),
          ),
        ]));
      },
    ),
    );
  }
}
