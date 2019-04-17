import 'dart:async';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/authentication/authentication_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class SearchRepository {
  String sortBy;

  SearchRepository({@required this.sortBy});

  Future<List<Item>> search(
      String query, int page, AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId, token: authenticationBloc.token)
        .search(query, page, sortBy, "1");
    return result.errorCode != null
        ? result.errorCode == 100 ? [] : throw result.errorMessage
        : result.response.items;
  }
}
