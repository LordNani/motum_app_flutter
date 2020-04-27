import 'dart:convert';
import 'package:corsac_jwt/corsac_jwt.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final String endpoint =
      'http://ec2-3-23-64-17.us-east-2.compute.amazonaws.com';
  static final storage = FlutterSecureStorage();

  Future<TokenPair> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    //TODO fetch DB
    TokenPair token;

//    print(jsonEncode({
//      'login': username,
//      'password': password,
//    }));

    http.Response response = await http.post(endpoint + '/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'login': username,
          'password': password,
        }));
    if (response.statusCode != 200) {
      print('Error on post login: ${response.body}');
      token = TokenPair('', '');
    } else {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      token = TokenPair(
          decodedResponse['refreshToken'], decodedResponse['accessToken']);
      print('Response body: ${response.body}');
    }
    return token;
  }

  Future<void> deleteToken() async {
//    await Future.delayed(Duration(seconds: 1));
    await storage.delete(key: 'refreshToken');
    debugPrint('Refresh token removed from storage');
    return;
  }

  Future<void> persistToken(TokenPair token) async {
    //await Future.delayed(Duration(seconds: 1));
    await storage.write(key: 'refreshToken', value: token.refreshToken);
    print(await storage.read(key: 'refreshToken'));
    //write to keystore
    debugPrint('Persist token : $token');
    return;
  }

  Future<bool> hasToken() async {
    String encodedToken = await storage.read(key: 'refreshToken');
    bool isValid = false;
    if (encodedToken != null) {
      try {
        final claimSet = JWT.parse(encodedToken);
        DateTime expirationDate =
            DateTime.fromMillisecondsSinceEpoch(claimSet.expiresAt * 1000);
        if (expirationDate.difference(DateTime.now()).inSeconds > 0) {
          isValid = true;
        }
        print('Token expires at : $expirationDate , isValid : $isValid');
      } catch (error) {
        print(error);
      }
    }
    return isValid;
  }
}

class TokenPair {
  final String refreshToken;
  final String accessToken;

  TokenPair(this.refreshToken, this.accessToken);

  @override
  String toString() {
    return 'TokenPair{refreshToken: $refreshToken, accessToken: $accessToken}';
  }
}
