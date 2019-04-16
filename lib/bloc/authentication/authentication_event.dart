import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'App Started';
}

class LoggedIn extends AuthenticationEvent {
  final Map<String, String> credential;

  LoggedIn({@required this.credential}) : super([credential]);

  @override
  String toString() => 'Logged In { credential: $credential }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}
