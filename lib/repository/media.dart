import 'dart:async';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/authentication/authentication_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/networking/api_client.dart';

class MediaRepository {
  final String threadId;
  final bool includeLink;

  MediaRepository({@required this.threadId, this.includeLink = false});

  Future<List<MediaContent>> fetchMedia(
      AuthenticationBloc authenticationBloc) async {
    final result = await ApiClient(
            userId: authenticationBloc.userId,
            token: authenticationBloc.token,
            deviceId: authenticationBloc.deviceId)
        .fetchMedia(threadId: threadId, includeLink: includeLink);
    return result.errorCode != null
        ? result.errorCode == 100 ? [] : throw result.errorMessage
        : result.response.mediaContents;
  }
}
