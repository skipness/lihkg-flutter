import 'dart:async';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/authentication/authentication_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class CategoryRepository {
  SubCategory subCategory;

  CategoryRepository({@required this.subCategory});

  Future<List<Item>> fetchCategory(
      int page, AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId, token: authenticationBloc.token)
        .fetchCategory(subCategory.url, subCategory.catId, page,
            query: subCategory.query.toJson());
    return result.errorCode != null
        ? result.errorCode == 100 ? [] : throw result.errorMessage
        : result.response.items;
  }
}
