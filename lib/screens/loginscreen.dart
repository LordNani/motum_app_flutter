import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Motum/models/AuthenticationBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color _orangeColor = Color.fromRGBO(248, 92, 38, 1);
  FocusNode _focusNodeLogin = FocusNode();
  FocusNode _focusNodePassword = FocusNode();
  bool _obscurePassword = true;

  void _showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);

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
                  Container(
                    margin: EdgeInsets.only(
                        top: 30, bottom: 0, right: 30, left: 30),
                    child: TextFormField(
                      onTap: _requestFocusOnLogin,
                      focusNode: _focusNodeLogin,
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
                        labelStyle: TextStyle(
                            color: _focusNodeLogin.hasFocus
                                ? _orangeColor
                                : Color.fromRGBO(0, 0, 0, 0.6)),
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide:
                                BorderSide(color: _orangeColor, width: 2)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 30, bottom: 0, right: 30, left: 30),
                    child: TextFormField(
                      onTap: _requestFocusOnPassword,
                      focusNode: _focusNodePassword,
                      obscureText: _obscurePassword,
//                      validator: (val) => val.length < 4 ? 'Password too short.' : null,
                      style: TextStyle(fontFamily: "Roboto", fontSize: 20),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: _showPassword,
                          child: Icon(_obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        labelText: "Password",
                        contentPadding: EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(218, 218, 218, 1),
                                width: 2)),
                        labelStyle: TextStyle(
                            color: _focusNodePassword.hasFocus
                                ? _orangeColor
                                : Color.fromRGBO(0, 0, 0, 0.6)),
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide:
                                BorderSide(color: _orangeColor, width: 2)),
                      ),
                    ),
                  ),
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
                            fontFamily: 'Ubuntu',fontSize: 16),
                      ),                      Expanded(
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

  void _requestFocusOnLogin() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodeLogin);
    });
  }

  void _requestFocusOnPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNodePassword);
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNodeLogin = FocusNode();
    _focusNodePassword = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeLogin.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }
}
