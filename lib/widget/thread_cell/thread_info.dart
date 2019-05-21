import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/thread_cell/thread_cell.dart';
import 'package:lihkg_flutter/widget/thread/user_modal_bottom_sheet.dart';

class ThreadInfo extends StatelessWidget {
  final Item thread;
  final ThreadItem threadItem;

  const ThreadInfo({@required this.thread, @required this.threadItem});

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
    final fontScale = PreferenceContext.of(context).preference;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(children: <Widget>[
        ThreadMsgNum(
            msgNumber: threadItem.msgNum,
            userId: threadItem.user.userId,
            threadUserId: thread.userId),
        SizedBox(width: 5),
        GestureDetector(
            child:
                UserNickname(user: threadItem.user, fontSize: 14 * fontScale),
            onTap: () => showModal(context)),
        Text(" • ",
            style: TextStyle(color: theme.hintColor, fontSize: 13 * fontScale)),
        ThreadReplyTime(
            replyTime: threadItem.replyTime, fontSize: 13 * fontScale),
      ]),
    );
  }
}
