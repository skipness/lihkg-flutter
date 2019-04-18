import 'dart:async';
import 'dart:math';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class MeRepository {
  final storage = FlutterSecureStorage();

  Future<Map<String, String>> authenticate({
    @required String email,
    @required String password,
  }) async {
    await persistDeviceId();
    final result =
        await ApiClient(deviceId: await readDeviceId()).login(email, password);
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

  Future<void> deleteDeviceId() async {
    return await storage.delete(key: 'deviceId');
  }

  Future<void> persistUserId(String userId) async {
    return await storage.write(key: 'userId', value: userId);
  }

  Future<void> persistToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future<void> persistDeviceId() async {
    const String component = "0123456789abcdef";
    String deviceId = "";
    for (int i = 0; i < 40; i++) {
      deviceId += component[(Random().nextDouble() * component.length).floor()];
    }
    return await storage.write(key: 'deviceId', value: deviceId);
  }

  Future<String> readUserId() async {
    return await storage.read(key: 'userId');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token');
  }

  Future<String> readDeviceId() async {
    return await storage.read(key: 'deviceId');
  }

  Future<bool> hasUserId() async {
    String value = await readUserId();
    return value != null;
  }

  Future<bool> hasToken() async {
    String value = await readToken();
    return value != null;
  }

  Future<bool> hasDeviceId() async {
    String value = await readDeviceId();
    return value != null;
  }
}
