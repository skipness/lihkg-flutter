import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/widget/common/modal_bottom_sheet.dart';
import 'package:share/share.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/page/page.dart';
import 'package:lihkg_flutter/widget/thread/thread_modal_bottom_sheet.dart';

class ThreadBottomAppBar extends StatefulWidget {
  @override
  _ThreadBottomAppBarState createState() => _ThreadBottomAppBarState();
}

class _ThreadBottomAppBarState extends State<ThreadBottomAppBar> {
  PreferenceBloc _preferenceBloc;
  ThreadBloc _threadBloc;
  ThreadActionBloc _threadActionBloc;
  int currentPage = 1;

  @override
  void initState() {
    _threadBloc = BlocProvider.of<ThreadBloc>(context);
    _threadActionBloc = BlocProvider.of<ThreadActionBloc>(context);
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomAppBar(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
      Expanded(
          child: IconButton(
              icon: Icon(Icons.favorite, color: theme.iconTheme.color),
              onPressed: () {})),
      Expanded(
          child: BlocBuilder(
        bloc: _preferenceBloc,
        builder: (BuildContext context, PreferenceState state) {
          return IconButton(
              icon: Icon(Icons.image, color: theme.iconTheme.color),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MediaList(
                              threadId: _threadBloc.threadRepository.threadId,
                              includeLink: (state is PreferenceLoaded
                                  ? state.preferences[MEDIA_MODE_INCLUDE_LINK]
                                      .value
                                  : false),
                            )));
              });
        },
      )),
      Expanded(
          child: IconButton(
              icon: Icon(Icons.thumbs_up_down, color: theme.iconTheme.color),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => ModalBottomSheet(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(
                                Icons.thumb_up,
                                color: theme.iconTheme.color,
                              ),
                              title: Text("正評"),
                              onTap: () {
                                _threadActionBloc.dispatch(VoteThread(
                                    threadId: _threadBloc.thread.threadId,
                                    isLike: true));
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.thumb_down,
                                color: theme.iconTheme.color,
                              ),
                              title: Text("負評"),
                              onTap: () {
                                _threadActionBloc.dispatch(VoteThread(
                                    threadId: _threadBloc.thread.threadId,
                                    isLike: false));
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )));
              })),
      Expanded(
          child: InkWell(
              child: Text('第$currentPage頁', textAlign: TextAlign.center),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => BlocProvider<ThreadBloc>(
                          bloc: _threadBloc,
                          child: ThreadModalBottomSheet(
                              currentPage: currentPage,
                              onPageChange: (page) {
                                setState(() => currentPage = page);
                              },
                              scrollController: ScrollController(
                                  initialScrollOffset:
                                      45.0 * (currentPage - 1))),
                        ));
              })),
      Expanded(
          child: IconButton(
              icon: Icon(Icons.reply, color: theme.iconTheme.color),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider<ThreadActionBloc>(
                            bloc: _threadActionBloc,
                            child: ReplyPage(
                              title: _threadBloc.thread.title,
                            ))));
              })),
      Expanded(
          child: IconButton(
              icon: Icon(Icons.share, color: theme.iconTheme.color),
              onPressed: () {
                Share.share(
                    '${_threadBloc.thread.title}\nhttps://lih.kg/${_threadBloc.thread.threadId}\n- 分享自 LIHKG 討論區');
              })),
      Expanded(
          child: IconButton(
              icon: Icon(Icons.arrow_downward, color: theme.iconTheme.color),
              onPressed: () {
                final _scrollController = PrimaryScrollController.of(context);
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.decelerate);
              }))
    ]));
  }
}
