import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/thread_cell/thread_cell.dart';
import 'package:lihkg_flutter/model/model.dart';

class ThreadCell extends StatelessWidget {
  final Item thread;
  final ThreadItem threadItem;

  const ThreadCell({Key key, @required this.thread, @required this.threadItem})
      : super(key: key);

  bool isPageNumberCell(String msgNum) =>
      (int.parse(msgNum) - 1) % 25 == 0 ? true : false;

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        isPageNumberCell(threadItem.msgNum)
            ? PageNumber(messageNumber: threadItem.msgNum)
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Ink(
            color: theme.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ThreadInfo(thread: thread, threadItem: threadItem),
                ThreadMessage(threadItem: threadItem),
                ThreadAction(thread: thread, threadItem: threadItem),
                const Divider(height: 0)
              ],
            ),
          ),
        )
      ],
    );
  }
}
