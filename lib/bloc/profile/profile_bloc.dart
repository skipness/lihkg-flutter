import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final String userId;

  ProfileBloc({@required this.profileRepository, @required this.userId}) {
    dispatch(FetchProfile());
  }

  @override
  ProfileState get initialState => ProfileUninitialized();

  @override
  Stream<ProfileEvent> transform(Stream<ProfileEvent> events) {
    return (events as Observable<ProfileEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<ProfileState> mapEventToState(
      ProfileState currentState, ProfileEvent event) async* {
    if (event is FetchProfile) {
      try {
        if (currentState is ProfileUninitialized) {
          final profile = await profileRepository.fetchProfile(userId);
          yield ProfileLoaded(profile: profile);
        }
      } catch (error) {
        yield ProfileError(error: error);
      }
    }
  }
}
