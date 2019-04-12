// import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/thread_cell/thread_cell.dart';
import 'package:lihkg_flutter/widget/thread/thread_bottom_app_bar.dart';
import 'package:lihkg_flutter/widget/shimmer/shimmer.dart';

class ThreadPage extends StatefulWidget {
  final Item thread;

  ThreadPage({@required this.thread});

  @override
  State createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  int currentPage = 1;
  PreferenceBloc _preferenceBloc;
  ThreadBloc _threadBloc;
  // Completer<void> _refreshCompleter;

  @override
  void initState() {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _threadBloc = ThreadBloc(threadId: widget.thread.threadId);
    // _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  void dispose() {
    _threadBloc.dispose();
    super.dispose();
  }

  Widget listCell(dynamic item) {
    final threadItem = (item as ThreadItem);
    return BlocBuilder<PreferenceEvent, PreferenceState>(
        bloc: _preferenceBloc,
        builder:
            (BuildContext context, PreferenceState state) =>
                PreferenceContext(
                    preference: (state is PreferenceLoaded
                        ? state.preferences[THREAD_FONT_SIZE].value
                        : 1),
                    child: ThreadCell(
                        key: ValueKey(threadItem.postId),
                        thread: widget.thread,
                        threadItem: threadItem)));
  }

  Widget listFooter(bool _) {
    var state = _threadBloc.currentState;
    if (state is ThreadLoaded) {
      if (state.hasReachedEnd) {
        final theme = Theme.of(context);
        TextStyle style = TextStyle(
            color: theme.accentColor, fontSize: theme.textTheme.title.fontSize);
        return int.parse(state.items.last.msgNum) ==
                int.parse(state.thread.maxReply)
            ? Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: Text('${state.thread.maxReply}', style: style)))
            : Container(
                padding: const EdgeInsets.all(15),
                child: Center(child: Text('F5', style: style)));
      } else {
        return const ShimmerCell();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
            title: AutoSizeText(
          '${widget.thread.title}',
          style: TextStyle(fontSize: 18.0, height: 0.9),
          minFontSize: 16.0,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
        bottomNavigationBar:
            BlocProvider(bloc: _threadBloc, child: ThreadBottomAppBar()),
        body: BlocBuilder<ThreadEvent, ThreadState>(
            bloc: _threadBloc,
            builder: (BuildContext context, ThreadState state) {
              final _scrollController = PrimaryScrollController.of(context);
              if (state is ThreadUninitialized) return const ShimmerList();
              if (state is ThreadError) return Container();
              if (state is ThreadLoaded) {
                // _refreshCompleter?.complete();
                // _refreshCompleter = Completer();
                return LiListView(
                  items: state.items,
                  cell: listCell,
                  footer: listFooter,
                  scrollController: _scrollController,
                  showScrollBar: false,
                  // canRefresh: _threadBloc.page > 1 ? true : false,
                  canRefresh: false,
                  hasReachedEnd: state.hasReachedEnd,
                  loadMore: () => _threadBloc
                      .dispatch(FetchThread(page: _threadBloc.page + 1)),
                  refresh: () {
                    // _threadBloc
                    //     .dispatch(FetchThread(page: _threadBloc.page - 1));
                    // return _refreshCompleter.future;
                  },
                );
              }
            }));
  }
}
