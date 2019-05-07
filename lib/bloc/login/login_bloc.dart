import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final MeRepository meRepository;
  final AuthenticationBloc authenticationBloc;
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  LoginBloc({
    @required this.meRepository,
    @required this.authenticationBloc,
  })  : assert(meRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final credential = await meRepository.authenticate(
          email: event.email,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(credential: credential));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }

  bool isEmailValidate(String email) {
    return _emailRegex.hasMatch(email) ? true : false;
  }

  bool isPasswordValidate(String password) {
    return password.isNotEmpty && password.length >= 6 ? true : false;
  }
}
