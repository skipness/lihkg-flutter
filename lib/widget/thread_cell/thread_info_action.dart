import 'package:flutter/material.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/thread_cell/thread_cell.dart';
import 'package:lihkg_flutter/widget/thread/user_modal_bottom_sheet.dart';

class ThreadInfoAction extends StatelessWidget {
  final Item thread;
  final ThreadItem threadItem;

  const ThreadInfoAction({@required this.thread, @required this.threadItem});

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return UserModalBottomSheet(
              user: threadItem.user, thread: thread, reply: threadItem);
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontScale = PreferenceContext.of(context).preference;
    return Row(children: <Widget>[
      ThreadMsgNum(
          msgNumber: threadItem.msgNum,
          userId: threadItem.user.userId,
          threadUserId: thread.userId),
      const SizedBox(width: 5),
      GestureDetector(
          child: UserNickname(
              user: threadItem.user,
              nickname: threadItem.userNickname,
              fontSize: 14 * fontScale),
          onTap: () => showModal(context)),
      const SizedBox(width: 5),
      ThreadReplyTime(
          replyTime: threadItem.replyTime, fontSize: 13 * fontScale),
      const Spacer(),
      IconButton(
          icon: Icon(Icons.more_vert, color: theme.hintColor),
          onPressed: () => showModal(context))
    ]);
  }
}
