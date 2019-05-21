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
            userId: authenticationBloc.userId,
            token: authenticationBloc.token,
            deviceId: authenticationBloc.deviceId)
        .fetchCategory(subCategory.url, subCategory.catId, page,
            query: subCategory.query.toJson());
    if (result.errorCode != null) {
      if (result.errorCode == 100) return [];
      throw result.errorMessage;
    } else {
      List<Item> items = result.response.items;
      items.removeWhere((Item item) =>
          item.status != "1" ||
          item.user.isBlocked == true ||
          item.user.isDisappear == true);
      return items;
    }
  }
}
