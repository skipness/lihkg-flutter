import 'dart:async';
import 'package:lihkg_flutter/bloc/authentication/authentication_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class ProfileRepository {
  Future<Profile> fetchProfile(AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId,
            token: authenticationBloc.token,
            deviceId: authenticationBloc.deviceId)
        .fetchProfile(authenticationBloc.userId);
    return result.errorCode != null ? throw result.errorMessage : result;
  }
}
