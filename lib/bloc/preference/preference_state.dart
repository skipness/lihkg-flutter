// code from https://github.com/namhyun-gu/preference-helper
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class PreferenceState extends Equatable {
  PreferenceState([List props = const []]) : super(props);
}

class PreferenceLoading extends PreferenceState {
  @override
  String toString() => 'Preference Loading';
}

class PreferenceError extends PreferenceState {
  @override
  String toString() => 'Get Preference Error';
}

class PreferenceLoaded extends PreferenceState {
  final Map<String, Preference> preferences;

  PreferenceLoaded({this.preferences}) : super([preferences]);

  @override
  String toString() => 'Preference Loaded {preferences: $preferences} }';
}
