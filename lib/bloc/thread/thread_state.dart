import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class ThreadState extends Equatable {
  ThreadState([List props = const []]) : super(props);
}

class ThreadUninitialized extends ThreadState {
  @override
  String toString() => 'Thread Uninitialized';
}

class ThreadError extends ThreadState {
  @override
  String toString() => 'Thread Error';
}

class ThreadLoaded extends ThreadState {
  final ThreadResponse thread;
  final List<ThreadItem> items;
  final bool hasReachedEnd;

  ThreadLoaded({this.thread, this.items, this.hasReachedEnd})
      : super([items, hasReachedEnd]);

  ThreadLoaded copyWith(
      {ThreadResponse thread, List<ThreadItem> items, bool hasReachedEnd}) {
    return ThreadLoaded(
        thread: thread ?? this.thread,
        items: items ?? this.items,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  @override
  String toString() =>
      'Thread Loaded { thread: $thread, items: $items, hasReachedEnd: $hasReachedEnd }\n';
}
