import 'package:flutter/material.dart';
import 'package:lihkg_flutter/util/util.dart';

class ThreadReplyTime extends StatelessWidget {
  final int replyTime;
  final double fontSize;

  const ThreadReplyTime({@required this.replyTime, @required this.fontSize});

  @override
  Widget build(BuildContext context) => Text(
        timeStringBuilder(replyTime),
        style: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).hintColor,
        ),
      );
}
