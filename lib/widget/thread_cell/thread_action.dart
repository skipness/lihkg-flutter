import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/page/page.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/thread_cell/thread_cell.dart';
import 'package:lihkg_flutter/widget/thread/user_modal_bottom_sheet.dart';

class ThreadAction extends StatelessWidget {
  final Item thread;
  final ThreadItem threadItem;

  const ThreadAction({@required this.thread, @required this.threadItem});

  void showModal(context) {
    final _threadActionBloc = BlocProvider.of<ThreadActionBloc>(context);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => BlocProvider<ThreadActionBloc>(
              bloc: _threadActionBloc,
              child: UserModalBottomSheet(thread: thread, reply: threadItem),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _threadActionBloc = BlocProvider.of<ThreadActionBloc>(context);
    return Row(children: <Widget>[
      ThreadVoteBox(thread: thread, threadItem: threadItem),
      const Spacer(),
      IconButton(
        icon: Icon(Icons.reply),
        color: theme.hintColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => BlocProvider<ThreadActionBloc>(
                    bloc: _threadActionBloc,
                    child: ReplyPage(
                      title: thread.title,
                      quote: threadItem,
                    ),
                  )));
        },
      ),
      IconButton(
          icon: Icon(Icons.more_vert, color: theme.hintColor),
          onPressed: () => showModal(context))
    ]);
  }
}
