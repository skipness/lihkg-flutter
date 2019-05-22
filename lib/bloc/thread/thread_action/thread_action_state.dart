import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ThreadActionState extends Equatable {
  ThreadActionState([List props = const []]) : super(props);
}

class NoThreadAction extends ThreadActionState {
  @override
  String toString() => 'No Thread Action';
}

class ThreadActionError extends ThreadActionState {
  final String error;

  ThreadActionError({@required this.error});

  @override
  String toString() => 'Thread Action Error { error: $error}';
}

class ThreadVoted extends ThreadActionState {
  @override
  String toString() => "Thread Voted";
}

class ThreadReplied extends ThreadActionState {
  @override
  String toString() => "Thread Replied";
}

class CommentVoted extends ThreadActionState {
  @override
  String toString() => "Comment Voted";
}

class BookmarkedThread extends ThreadActionState {
  @override
  String toString() => "Bookmarked Thread";
}

class UnbookmarkedThread extends ThreadActionState {
  @override
  String toString() => "Unbookmarked Thread";
}
