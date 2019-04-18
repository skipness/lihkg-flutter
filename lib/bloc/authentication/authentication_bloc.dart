import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/repository/repository.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final MeRepository meRepository;
  String userId;
  String token;
  String deviceId;

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
      final bool hasDeviceId = await meRepository.hasDeviceId();
      if (hasToken && hasUserId && hasDeviceId) {
        userId = await meRepository.readUserId();
        token = await meRepository.readToken();
        deviceId = await meRepository.readDeviceId();
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await meRepository.persistToken(event.credential["token"]);
      token = event.credential["token"];
      await meRepository.persistUserId(event.credential["userId"]);
      userId = event.credential["userId"];
      deviceId = await meRepository.readDeviceId();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      userId = null;
      token = null;
      deviceId = null;
      await meRepository.deleteToken();
      await meRepository.deleteUserId();
      await meRepository.deleteDeviceId();
      yield AuthenticationUnauthenticated();
    }
  }
}
