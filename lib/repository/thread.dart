import 'dart:async';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/authentication/authentication_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class ThreadRepository {
  String threadId;

  ThreadRepository({@required this.threadId});

  Future<ThreadResponse> fetchThread(
      int page, AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId, token: authenticationBloc.token)
        .fetchThread(threadId: threadId, page: page);

    if (result.errorCode != null) {
      throw result.errorMessage;
    } else {
      ThreadResponse response = result.response;
      response.itemData.removeWhere((ThreadItem item) => item.status != "1");
      return response;
    }
  }
}
