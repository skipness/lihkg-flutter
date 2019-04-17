import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class MeRepository {
  final storage = FlutterSecureStorage();

  Future<Map<String, String>> authenticate({
    @required String email,
    @required String password,
  }) async {
    final result = await ApiClient().login(email, password);
    if (result.errorCode != null) {
      throw result.errorMessage;
    } else {
      return {
        'userId': result.response.me.userId,
        'token': result.response.token
      };
    }
  }

  Future<void> deleteUserId() async {
    return await storage.delete(key: 'userId');
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: 'token');
  }

  Future<void> persistUserId(String userId) async {
    return await storage.write(key: 'userId', value: userId);
  }

  Future<void> persistToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future<String> readUserId() async {
    return await storage.read(key: 'userId');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token');
  }

  Future<bool> hasUserId() async {
    String value = await readUserId();
    return value != null;
  }

  Future<bool> hasToken() async {
    String value = await readToken();
    return value != null;
  }
}
