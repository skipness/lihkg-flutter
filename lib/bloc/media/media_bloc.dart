import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/networking/api_client.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:rxdart/rxdart.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  String threadId;
  bool includeLink;

  MediaBloc({@required this.threadId, this.includeLink = false}) {
    dispatch(FetchMedia());
  }

  @override
  MediaState get initialState => MediaUninitialized();

  @override
  Stream<MediaEvent> transform(Stream<MediaEvent> events) {
    return (events as Observable<MediaEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<MediaState> mapEventToState(
      MediaState currentState, MediaEvent event) async* {
    if (event is FetchMedia) {
      try {
        if (currentState is MediaUninitialized) {
          final items = await _fetchMedia();
          yield MediaLoaded(items: items);
        }
      } catch (_) {
        yield MediaError();
      }
    }
  }

  Future<List<MediaContent>> _fetchMedia() async {
    try {
      final result = await ApiClient()
          .fetchMedia(threadId: threadId, includeLink: includeLink);
      return result.response.mediaContents;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
