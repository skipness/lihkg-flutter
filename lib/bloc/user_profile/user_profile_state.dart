import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class UserProfileState extends Equatable {
  UserProfileState([List props = const []]) : super(props);
}

class UserProfileUninitialized extends UserProfileState {
  @override
  String toString() => 'User Profile Uninitialized';
}

class UserProfileError extends UserProfileState {
  @override
  String toString() => 'User Profile Error';
}

class UserProfileLoaded extends UserProfileState {
  final List<Item> items;
  final bool hasReachedEnd;

  UserProfileLoaded({this.items, this.hasReachedEnd})
      : super([items, hasReachedEnd]);

  UserProfileLoaded copyWith({bool hasReachedEnd}) {
    return UserProfileLoaded(
        items: items ?? this.items,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  @override
  String toString() =>
      'User Profile Loaded { items: $items, hasReachedEnd: $hasReachedEnd }\n';
}
