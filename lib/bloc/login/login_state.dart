import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'Login Initial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'Login Loading';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'Login Failure { error: $error }';
}