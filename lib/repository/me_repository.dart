import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class MeRepository {
  final storage = FlutterSecureStorage();

  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
    final result = await ApiClient().login(email, password);
    if (result.errorCode != null) {
      throw result.errorMessage;
    } else {
      return result.response.token;
    }
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: 'token');
  }

  Future<void> persistToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }
  
  Future<bool> hasToken() async {
    String value = await storage.read(key: 'token');
    return value != null;
  }
}
