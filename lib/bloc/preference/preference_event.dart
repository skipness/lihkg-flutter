// code from https://github.com/namhyun-gu/preference-helper
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/preference.dart';

abstract class PreferenceEvent extends Equatable {
  PreferenceEvent([List props = const []]) : super(props);
}

class GetPreference extends PreferenceEvent {
  @override
  String toString() => 'Get Preference';
}

class SetPreference extends PreferenceEvent {
  Preference preference;

  SetPreference({@required this.preference}) : super([preference]);

  @override
  String toString() => 'Set Preference {preferences: $preference }';
}
