import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/networking/api_client.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  String userId;
  String query;
  int page;

  UserProfileBloc(
      {@required this.userId, @required this.query, this.page = 1}) {
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
          final items = await _fetchUserProfile(page);
          yield UserProfileLoaded(
              items: items, hasReachedEnd: items.isEmpty ? true : false);
        }

        if (currentState is UserProfileLoaded) {
          page = page + 1;
          final items = await _fetchUserProfile(page);
          yield items.isEmpty
              ? currentState.copyWith(hasReachedEnd: true)
              : UserProfileLoaded(
                  items: currentState.items + items, hasReachedEnd: false);
        }
      } catch (_) {
        yield UserProfileError();
      }
    }

    if (event is RefreshUserProfile) {
      try {
        page = 1;
        final items = await _fetchUserProfile(page);
        yield UserProfileLoaded(items: items, hasReachedEnd: false);
      } catch (_) {
        yield currentState;
      }
    }
  }

  bool _hasReachedEnd(UserProfileState state) =>
      state is UserProfileLoaded && state.hasReachedEnd;

  Future<List<Item>> _fetchUserProfile(int page) async {
    final result = await ApiClient()
        .fetchUserProfile(userId: userId, page: page, query: query);
    if (result.errorCode == 100) {
      return [];
    } else {
      return result.response.items;
    }
  }
}
