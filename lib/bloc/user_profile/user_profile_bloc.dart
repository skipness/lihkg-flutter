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
  Stream<UserProfileState> transform(Stream<UserProfileEvent> events,
      Stream<UserProfileState> Function(UserProfileEvent event) next) {
    return super.transform(
        (events as Observable<UserProfileEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
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
              ? (currentState as UserProfileLoaded)
                  .copyWith(hasReachedEnd: true)
              : UserProfileLoaded(
                  items: (currentState as UserProfileLoaded).items + items,
                  hasReachedEnd: false);
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
