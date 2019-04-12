import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);
}

class AppUninitialized extends AppState {
  @override
  String toString() => 'App Uninitialized';
}

class AppError extends AppState {
  @override
  String toString() => 'App Error';
}

class AppLoaded extends AppState {
  final SysProps systemProps;

  AppLoaded({this.systemProps}) : super([systemProps]);

  @override
  String toString() => 'App Loaded { systemProps: $systemProps }\n';
}
