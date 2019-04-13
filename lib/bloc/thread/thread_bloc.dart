import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/networking/api_client.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:rxdart/rxdart.dart';

class ThreadBloc extends Bloc<ThreadEvent, ThreadState> {
  String threadId;
  ThreadResponse _thread;
  int page;

  ThreadBloc({@required this.threadId, this.page = 1}) {
    dispatch(FetchThread(page: page));
  }

  @override
  ThreadState get initialState => ThreadUninitialized();

  @override
  Stream<ThreadEvent> transform(Stream<ThreadEvent> events) {
    return (events as Observable<ThreadEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<ThreadState> mapEventToState(
      ThreadState currentState, ThreadEvent event) async* {
    if (event is FetchThread) {
      var isNext = event.page > page;
      page = event.page;
      try {
        if (currentState is ThreadUninitialized) {
          final ThreadResponse thread = await _fetchThread(page);
          final List<ThreadItem> items = thread.itemData
            ..removeWhere((ThreadItem item) => item.status != "1");
          this.thread = thread;
          yield ThreadLoaded(
              thread: thread,
              items: items,
              hasReachedEnd:
                  (items.isEmpty || items.last.msgNum == thread.noOfReply) ||
                          (items.last.msgNum == thread.maxReply)
                      ? true
                      : false);
        }

        if (currentState is ThreadLoaded && !_hasReachedEnd(currentState)) {
          final ThreadResponse thread = await _fetchThread(page);
          final List<ThreadItem> items = thread.itemData
            ..removeWhere((ThreadItem item) => item.status != "1");
          this.thread = thread;
          yield ThreadLoaded(
              thread: thread,
              items: isNext
                  ? currentState.items + items
                  : items + currentState.items,
              hasReachedEnd:
                  (items.isEmpty || items.last.msgNum == thread.noOfReply) ||
                          (items.last.msgNum == thread.maxReply)
                      ? true
                      : false);
        }
      } catch (_) {
        yield ThreadError();
      }
    }

    if (event is ChangePage) {
      page = event.page;
      try {
        yield ThreadUninitialized();
        final thread = await _fetchThread(page);
        final items = thread.itemData;
        this.thread = thread;
        yield ThreadLoaded(
            thread: thread,
            items: items,
            hasReachedEnd:
                (items.isEmpty || items.last.msgNum == thread.noOfReply) ||
                        (items.last.msgNum == thread.maxReply)
                    ? true
                    : false);
      } catch (_) {
        yield ThreadError();
      }
    }
  }

  bool _hasReachedEnd(ThreadState state) =>
      state is ThreadLoaded && state.hasReachedEnd;

  ThreadResponse get thread => this._thread;
  set thread(ThreadResponse thread) => _thread = thread;

  Future<ThreadResponse> _fetchThread(int page) async {
    try {
      final result =
          await ApiClient().fetchThread(threadId: threadId, page: page);
      return result.response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
