import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);
}

class FetchProfile extends ProfileEvent {
  @override
  String toString() => 'Fetch Profile';
}
