import 'package:equatable/equatable.dart';

abstract class MediaEvent extends Equatable {
  MediaEvent([List props = const []]) : super(props);
}

class FetchMedia extends MediaEvent {
  @override
  String toString() => 'Fetch Media';
}
