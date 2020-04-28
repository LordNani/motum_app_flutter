import 'package:Motum/models/AuthenticationBloc.dart';
import 'package:Motum/models/UserRepository.dart';
import 'package:Motum/screens/login/LoginBloc.dart';
import 'package:Motum/screens/login/LoginEvent.dart';
import 'package:Motum/screens/login/LoginState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final Color _orangeColor = Color.fromRGBO(248, 92, 38, 1);
  final UserRepository repository;

  SignUpScreen({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              repository: this.repository);
        },
        child: Container(
            color: Color(0xFDFDFBFF),
            alignment: Alignment.center,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 40,bottom: 40),
                  child: Text("Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: "Ubuntu",
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(30, 31, 32, 1.0),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LoginForm(),
                    Container(
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width / 5 * 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Have an account?",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500)),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: _orangeColor,
                                      fontSize: 19,
                                      decoration: TextDecoration.underline)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
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
  final _passwordConfirmController = TextEditingController();
  bool _policyCheckbox = false;
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
              child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                bottom: 100,
                left: MediaQuery.of(context).size.width / 2 - 15,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Container(
                  margin:
                      EdgeInsets.only(top: 30, bottom: 0, right: 30, left: 30),
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontFamily: "Roboto", fontSize: 20),
                    decoration: InputDecoration(
                      labelText: "Login",
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(218, 218, 218, 1),
                              width: 2)),
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide:
                              BorderSide(color: _orangeColor, width: 2)),
                    ),
                  ),
                ),
                //PASSWORD
                Container(
                  margin:
                      EdgeInsets.only(top: 30, bottom: 0, right: 30, left: 30),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(fontFamily: "Roboto", fontSize: 20),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _showPassword,
                        child: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: "Password",
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(218, 218, 218, 1),
                              width: 2)),
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide:
                              BorderSide(color: _orangeColor, width: 2)),
                    ),
                  ),
                ),
                //PASSWORD CONFIRM
                Container(
                  margin:
                      EdgeInsets.only(top: 30, bottom: 10, right: 30, left: 30),
                  child: TextFormField(
                    controller: _passwordConfirmController,
                    obscureText: _obscurePassword,
                    style: TextStyle(fontFamily: "Roboto", fontSize: 20),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: _showPassword,
                        child: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      labelText: "Confirm Password",
                      contentPadding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(218, 218, 218, 1),
                              width: 2)),
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide:
                              BorderSide(color: _orangeColor, width: 2)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.redAccent,
                        value: _policyCheckbox,
                        onChanged: (val) {
                          setState(() {
                            _policyCheckbox = val;
                          });
                        },
                      ),
                      Text(
                        "I agree with terms and conditions",
                        style: TextStyle(
                            letterSpacing: 0.15,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: ButtonTheme(
                    height: 45,
                    minWidth: MediaQuery.of(context).size.width * 0.85,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      elevation: 6,
                      color: _orangeColor,
                      onPressed:
                          state is! LoginLoading ? _onLoginButtonPressed : null,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ));
        },
      ),
    );
  }
}
