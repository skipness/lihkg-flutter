import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/repository/repository.dart';
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
  ThreadActionBloc _threadActionBloc;
  ThreadRepository _threadRepository;
  // Completer<void> _refreshCompleter;

  @override
  void initState() {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _threadRepository = ThreadRepository(threadId: widget.thread.threadId);
    _threadBloc = ThreadBloc(
        threadRepository: _threadRepository,
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    _threadActionBloc = ThreadActionBloc(
        threadRepository: _threadRepository,
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    // _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  void dispose() {
    _threadBloc.dispose();
    _threadActionBloc.dispose();
    super.dispose();
  }

  Widget listCell(dynamic item) {
    final threadItem = (item as ThreadItem);
    return BlocBuilder<PreferenceEvent, PreferenceState>(
        bloc: _preferenceBloc,
        builder: (BuildContext context, PreferenceState state) =>
            PreferenceContext(
                preference: (state is PreferenceLoaded
                    ? state.preferences[THREAD_FONT_SIZE].value
                    : 1),
                child: BlocProvider<ThreadActionBloc>(
                  bloc: _threadActionBloc,
                  child: ThreadCell(
                      key: ValueKey(threadItem.postId),
                      thread: widget.thread,
                      threadItem: threadItem),
                )));
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
    return Scaffold(
        appBar: AppBar(
            title: AutoSizeText(
          '${widget.thread.title}',
          style: TextStyle(fontSize: 18.0, height: 0.9),
          minFontSize: 16.0,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )),
        bottomNavigationBar: BlocListener<ThreadActionEvent, ThreadActionState>(
          bloc: _threadActionBloc,
          listener: (BuildContext context, ThreadActionState state) {
            if (state is ThreadActionError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 5),
              ));
            }

            if (state is ThreadVoted) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("成功評分"), duration: Duration(seconds: 5)));
            }

            if (state is ThreadReplied) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("成功回覆"), duration: Duration(seconds: 5)));
            }

            if (state is BookmarkedThread) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("成功留名"), duration: Duration(seconds: 5)));
            }

            if (state is UnbookmarkedThread) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("成功取消留名"), duration: Duration(seconds: 5)));
            }
          },
          child: BlocProviderTree(blocProviders: [
            BlocProvider<ThreadBloc>(bloc: _threadBloc),
            BlocProvider<ThreadActionBloc>(bloc: _threadActionBloc)
          ], child: ThreadBottomAppBar()),
        ),
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
