import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  ThreadRepository threadRepository;
  AuthenticationBloc authenticationBloc;
  ThreadResponse _thread;
  int page;

  ThreadBloc(
      {@required this.threadRepository,
      @required this.authenticationBloc,
      this.page = 1}) {
    dispatch(FetchThread(page: page));
  }

  @override
  ThreadState get initialState => ThreadUninitialized();

  @override
  Stream<ThreadState> transform(Stream<ThreadEvent> events,
      Stream<ThreadState> Function(ThreadEvent event) next) {
    return super.transform(
        (events as Observable<ThreadEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<ThreadState> mapEventToState(ThreadEvent event) async* {
    if (event is FetchThread) {
      var isNext = event.page > page;
      page = event.page;
      try {
        if (currentState is ThreadUninitialized) {
          final ThreadResponse thread =
              await threadRepository.fetchThread(page, authenticationBloc);
          this.thread = thread;
          yield ThreadLoaded(
              thread: thread,
              items: thread.itemData,
              hasReachedEnd: (thread.itemData.isEmpty ||
                          thread.itemData.last.msgNum == thread.noOfReply) ||
                      (thread.itemData.last.msgNum == thread.maxReply)
                  ? true
                  : false);
        }

        if (currentState is ThreadLoaded && !_hasReachedEnd(currentState)) {
          final ThreadResponse thread =
              await threadRepository.fetchThread(page, authenticationBloc);
          this.thread = thread;
          yield ThreadLoaded(
              thread: thread,
              items: isNext
                  ? (currentState as ThreadLoaded).items + thread.itemData
                  : thread.itemData + (currentState as ThreadLoaded).items,
              hasReachedEnd: (thread.itemData.isEmpty ||
                          thread.itemData.last.msgNum == thread.noOfReply) ||
                      (thread.itemData.last.msgNum == thread.maxReply)
                  ? true
                  : false);
        }
      } catch (error) {
        yield ThreadError(error: error.toString());
      }
    }

    if (event is ChangePage) {
      page = event.page;
      try {
        yield ThreadUninitialized();
        final thread =
            await threadRepository.fetchThread(page, authenticationBloc);
        this.thread = thread;
        yield ThreadLoaded(
            thread: thread,
            items: thread.itemData,
            hasReachedEnd: (thread.itemData.isEmpty ||
                        thread.itemData.last.msgNum == thread.noOfReply) ||
                    (thread.itemData.last.msgNum == thread.maxReply)
                ? true
                : false);
      } catch (error) {
        yield ThreadError(error: error.toString());
      }
    }
  }

  bool _hasReachedEnd(ThreadState state) =>
      state is ThreadLoaded && state.hasReachedEnd;

  ThreadResponse get thread => this._thread;
  set thread(ThreadResponse thread) => _thread = thread;
}
