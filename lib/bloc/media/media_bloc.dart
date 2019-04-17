import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  final MediaRepository mediaRepository;
  final AuthenticationBloc authenticationBloc;

  MediaBloc(
      {@required this.mediaRepository, @required this.authenticationBloc}) {
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
          final items = await mediaRepository.fetchMedia(authenticationBloc);
          yield MediaLoaded(items: items);
        }
      } catch (error) {
        yield MediaError(error: error.toString());
      }
    }
  }
}
