import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ThreadEvent extends Equatable {
  ThreadEvent([List props = const []]) : super(props);
}

class FetchThread extends ThreadEvent {
  int page;

  FetchThread({this.page}) : super([page]);

  @override
  String toString() => 'Fetch Thread';
}

class ChangePage extends ThreadEvent {
  int page;

  ChangePage({@required this.page}) : super([page]);
}

class RefreshThread extends ThreadEvent {
  @override
  String toString() => 'Refresh Thread';
}
