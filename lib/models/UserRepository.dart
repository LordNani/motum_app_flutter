import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final _storage = FlutterSecureStorage();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    //TODO fetch DB
    return 'token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 1));
    debugPrint('==token deleted==');
    return;
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1));
    //write to keystore
    await _storage.write(key: 'access', value: token);
    debugPrint('Persist token : $token');
    return;
  }

  Future<bool> hasToken() async {
  await Future.delayed(Duration(seconds: 1));
  debugPrint('==token deleted==');
  String token = await _storage.read(key: 'access');
  return token.isEmpty? false : true;
  }


}
