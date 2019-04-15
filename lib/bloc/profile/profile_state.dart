import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);
}

class ProfileUninitialized extends ProfileState {
  @override
  String toString() => 'Profile Uninitialized';
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({@required this.error}) : super([error]);

  @override
  String toString() => 'Profile Error { error: $error }';
}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded({this.profile}) : super([profile]);

  @override
  String toString() => 'Profile Loaded { profile: $profile }\n';
}
