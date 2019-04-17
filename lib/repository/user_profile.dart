import 'dart:async';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/authentication/authentication_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class UserProfileRepository {
  String userId;
  String sortBy;

  UserProfileRepository({@required this.userId, @required this.sortBy});

  Future<List<Item>> fetchUserProfile(
      int page, AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId, token: authenticationBloc.token)
        .fetchUserProfile(userId: userId, page: page, sortBy: sortBy);
    return result.errorCode != null
        ? result.errorCode == 100 ? [] : throw result.errorMessage
        : result.response.items;
  }
}
