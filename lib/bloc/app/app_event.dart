import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {}

class FetchSysProps extends AppEvent {
  @override
  String toString() => 'Fetch System Props';
}

// class RefreshSysProps extends AppEvent {
//   @override
//   String toString() => 'Refresh System Props';
// }
