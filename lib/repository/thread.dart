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
            userId: authenticationBloc.userId,
            token: authenticationBloc.token,
            deviceId: authenticationBloc.deviceId)
        .fetchThread(threadId: threadId, page: page);

    if (result.errorCode != null) {
      throw result.errorMessage;
    } else {
      ThreadResponse response = result.response;
      response.itemData.removeWhere((ThreadItem item) =>
          item.status != "1" ||
          item.user.isBlocked == true ||
          item.user.isDisappear == true);
      return response;
    }
  }

  Future<bool> voteThread(
      bool isLike, AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId,
            token: authenticationBloc.token,
            deviceId: authenticationBloc.deviceId)
        .votePost(threadId, isLike);
    if (result.errorCode != null) {
      throw result.errorMessage;
    } else {
      return result.response.isLike;
    }
  }

  Future<void> reply(String content, AuthenticationBloc authenticationBloc,
      String quoteId) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId,
            token: authenticationBloc.token,
            deviceId: authenticationBloc.deviceId)
        .reply(threadId, content, quoteId: quoteId);
    if (result.errorCode != null) {
      throw result.errorMessage;
    } else {
      return result.response;
    }
  }
}
