import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  UserProfileEvent([List props = const []]) : super(props);
}

class FetchUserProfile extends UserProfileEvent {
  int page;

  FetchUserProfile({this.page}) : super([page]);

  @override
  String toString() => 'Fetch User Profile';
}

class RefreshUserProfile extends UserProfileEvent {
  @override
  String toString() => 'Refresh User Profile';
}
