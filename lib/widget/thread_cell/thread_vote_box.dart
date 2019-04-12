import 'package:flutter/material.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

class ThreadVoteBox extends StatelessWidget {
  final Item thread;
  final ThreadItem threadItem;

  const ThreadVoteBox({@required this.thread, @required this.threadItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontScale = PreferenceContext.of(context).preference;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 18),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                  threadItem.msgNum == '1'
                      ? Icons.thumb_up
                      : Icons.arrow_upward,
                  size: 13 * fontScale,
                  color: theme.disabledColor),
            ),
            Text(
              '${threadItem.msgNum == '1' ? thread.likeCount : threadItem.likeCount}',
              style: TextStyle(
                  fontSize: 13 * fontScale, color: theme.disabledColor),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                threadItem.msgNum == '1'
                    ? Icons.thumb_down
                    : Icons.arrow_downward,
                size: 13 * fontScale,
                color: theme.disabledColor,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  '${threadItem.msgNum == '1' ? thread.dislikeCount : threadItem.dislikeCount}',
                  style: TextStyle(
                      fontSize: 13 * fontScale, color: theme.disabledColor),
                )),
          ],
        ),
      ),
    );
  }
}
