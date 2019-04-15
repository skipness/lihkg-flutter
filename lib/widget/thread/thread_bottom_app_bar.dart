import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/page/page.dart';
import 'package:lihkg_flutter/widget/thread/thread_modal_bottom_sheet.dart';

class ThreadBottomAppBar extends StatefulWidget {
  @override
  _ThreadBottomAppBarState createState() => _ThreadBottomAppBarState();
}

class _ThreadBottomAppBarState extends State<ThreadBottomAppBar> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _threadBloc = BlocProvider.of<ThreadBloc>(context);
    final _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    return BottomAppBar(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
      // Expanded(
      //     child: IconButton(
      //         icon: Icon(Icons.favorite, color: theme.iconTheme.color),
      //         onPressed: () {})),
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
                              threadId: _threadBloc.threadId,
                              includeLink: (state is PreferenceLoaded
                                  ? state.preferences[MEDIA_MODE_INCLUDE_LINK]
                                      .value
                                  : false),
                            )));
              });
        },
      )),
      // Expanded(
      //     child: IconButton(
      //         icon: Icon(Icons.thumbs_up_down, color: theme.iconTheme.color),
      //         onPressed: () {})),
      Expanded(
          child: InkWell(
              child: Text('第$currentPage頁', textAlign: TextAlign.center),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => BlocProvider(
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
      // Expanded(
      //     child: IconButton(
      //         icon: Icon(Icons.reply, color: theme.iconTheme.color),
      //         onPressed: () {})),
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
