import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class ThreadActionBloc extends Bloc<ThreadActionEvent, ThreadActionState> {
  ThreadRepository threadRepository;
  AuthenticationBloc authenticationBloc;

  ThreadActionBloc({
    @required this.threadRepository,
    @required this.authenticationBloc,
  });

  @override
  ThreadActionState get initialState => NoThreadAction();

  @override
  Stream<ThreadActionState> transform(Stream<ThreadActionEvent> events,
      Stream<ThreadActionState> Function(ThreadActionEvent event) next) {
    return super.transform(
        (events as Observable<ThreadActionEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<ThreadActionState> mapEventToState(ThreadActionEvent event) async* {
    if (event is VoteThread) {
      try {
        await threadRepository.voteThread(event.isLike, authenticationBloc);
        yield ThreadVoted();
      } catch (error) {
        yield ThreadActionError(error: error.toString());
        yield NoThreadAction();
      }
    }

    if (event is VoteComment) {
      try {} catch (error) {
        yield ThreadActionError(error: error.toString());
        yield NoThreadAction();
      }
    }

    if (event is ReplyThread) {
      try {
        await threadRepository.reply(
            event.content, authenticationBloc, event.quoteId);
        yield ThreadReplied();
      } catch (error) {
        yield ThreadActionError(error: error.toString());
        yield NoThreadAction();
      }
    }
  }
}
