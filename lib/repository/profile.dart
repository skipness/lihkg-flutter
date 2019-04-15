import 'dart:async';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class ProfileRepository {
  Future<Profile> fetchProfile(String userId) async {
    final result = await ApiClient().fetchProfile(userId);
    return result.errorCode != null ? throw result.errorMessage : result;
  }
}
