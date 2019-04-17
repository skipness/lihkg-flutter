import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileRepository userProfileRepository;
  AuthenticationBloc authenticationBloc;
  int page;

  UserProfileBloc(
      {@required this.userProfileRepository,
      @required this.authenticationBloc,
      this.page = 1}) {
    dispatch(FetchUserProfile(page: page));
  }

  @override
  UserProfileState get initialState => UserProfileUninitialized();

  @override
  Stream<UserProfileEvent> transform(Stream<UserProfileEvent> events) {
    return (events as Observable<UserProfileEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<UserProfileState> mapEventToState(
      UserProfileState currentState, UserProfileEvent event) async* {
    if (event is FetchUserProfile && !_hasReachedEnd(currentState)) {
      try {
        if (currentState is UserProfileUninitialized) {
          final items = await userProfileRepository.fetchUserProfile(
              page, authenticationBloc);
          yield UserProfileLoaded(
              items: items, hasReachedEnd: items.isEmpty ? true : false);
        }

        if (currentState is UserProfileLoaded) {
          page = page + 1;
          final items = await userProfileRepository.fetchUserProfile(
              page, authenticationBloc);
          yield items.isEmpty
              ? currentState.copyWith(hasReachedEnd: true)
              : UserProfileLoaded(
                  items: currentState.items + items, hasReachedEnd: false);
        }
      } catch (error) {
        yield UserProfileError(error: error.toString());
      }
    }

    if (event is RefreshUserProfile) {
      try {
        page = 1;
        final items = await userProfileRepository.fetchUserProfile(
            page, authenticationBloc);
        yield UserProfileLoaded(items: items, hasReachedEnd: false);
      } catch (_) {
        yield currentState;
      }
    }
  }

  bool _hasReachedEnd(UserProfileState state) =>
      state is UserProfileLoaded && state.hasReachedEnd;
}
