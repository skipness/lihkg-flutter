import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthenticationBloc authenticationBloc;
  final ProfileRepository profileRepository;

  ProfileBloc({
    @required this.authenticationBloc,
    @required this.profileRepository,
  }) {
    dispatch(FetchProfile());
  }

  @override
  ProfileState get initialState => ProfileUninitialized();

  @override
  Stream<ProfileState> transform(Stream<ProfileEvent> events,
      Stream<ProfileState> Function(ProfileEvent event) next) {
    return super.transform(
        (events as Observable<ProfileEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfile) {
      try {
        if (currentState is ProfileUninitialized) {
          final profile =
              await profileRepository.fetchProfile(authenticationBloc);
          yield ProfileLoaded(profile: profile);
        }
      } catch (error) {
        yield ProfileError(error: error.toString());
      }
    }
  }
}
