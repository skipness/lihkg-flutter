import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/thread_cell/thread_action.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ThreadActionEvent extends Equatable {
  ThreadActionEvent([List props = const []]) : super(props);
}

class VoteThread extends ThreadActionEvent {
  String threadId;
  bool isLike;

  VoteThread({this.threadId, this.isLike}) : super([threadId, isLike]);

  @override
  String toString() => 'Vote Thread $threadId';
}

class ReplyThread extends ThreadActionEvent {
  String threadId;
  String content;
  String quoteId;

  ReplyThread({@required this.threadId, @required this.content, this.quoteId})
      : super([threadId, content, quoteId]);

  @override
  String toString() => 'Reply Thread $threadId, content: $content';
}

class VoteComment extends ThreadActionEvent {
  String threadId;
  String postId;

  VoteComment({@required this.threadId, @required this.postId})
      : super([threadId, postId]);

  @override
  String toString() => 'Vote Thread $threadId for post $postId';
}

class BookmarkThread extends ThreadActionEvent {
  String threadId;
  int page;

  BookmarkThread({@required this.threadId, @required this.page});

  @override
  String toString() => 'Bookmark thread $threadId, page $page';
}

class UnbookmarkThread extends ThreadActionEvent {
  String threadId;

  UnbookmarkThread({@required this.threadId});

  @override
  String toString() => 'Unbookmark thread $threadId';
}
