import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

class ThreadMsgNum extends StatelessWidget {
  final String msgNumber;
  final String userId;
  final String threadUserId;

  const ThreadMsgNum(
      {@required this.msgNumber,
      @required this.userId,
      @required this.threadUserId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontScale = PreferenceContext.of(context).preference;
    return Text(
      '#$msgNumber',
      style: TextStyle(
          fontSize: 13 * fontScale,
          color: userId == threadUserId
              ? const Color(0xffffc107)
              : theme.hintColor),
    );
  }
}
