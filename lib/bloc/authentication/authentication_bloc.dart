import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/repository/repository.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final MeRepository meRepository;

  AuthenticationBloc({@required this.meRepository})
      : assert(meRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationState currentState,
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await meRepository.hasToken();
      final bool hasUserId = await meRepository.hasUserId();
      if (hasToken && hasUserId) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await meRepository.persistToken(event.credential["token"]);
      await meRepository.persistUserId(event.credential["userId"]);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await meRepository.deleteToken();
      await meRepository.deleteUserId();
      yield AuthenticationUnauthenticated();
    }
  }
}
