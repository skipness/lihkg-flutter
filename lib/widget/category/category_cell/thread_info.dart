import 'package:flutter/material.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

class ThreadInfo extends StatelessWidget {
  final Item thread;

  const ThreadInfo({@required this.thread});

  int _getRating(String like, String dislike) {
    return int.parse(like) - int.parse(dislike);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontScale = PreferenceContext.of(context).preference;
    return Container(
      child: Row(
        children: <Widget>[
          UserNickname(user: thread.user, fontSize: 13 * fontScale),
          const SizedBox(width: 15),
          Icon(
            Icons.comment,
            size: 13 * fontScale,
            color: theme.hintColor,
          ),
          const SizedBox(width: 5),
          Text(
            thread.noOfReply,
            style: TextStyle(
              fontSize: 13 * fontScale,
              color: theme.hintColor,
            ),
          ),
          const SizedBox(width: 15),
          Icon(
            _getRating(thread.likeCount, thread.dislikeCount) >= 0
                ? Icons.thumb_up
                : Icons.thumb_down,
            size: 13 * fontScale,
            color: theme.hintColor,
          ),
          const SizedBox(width: 5),
          Text(
            _getRating(thread.likeCount, thread.dislikeCount).toString(),
            style: TextStyle(
              fontSize: 13 * fontScale,
              color: theme.hintColor,
            ),
          ),
          const SizedBox(width: 15),
          ThreadReplyTime(
              replyTime: thread.lastReplyTime, fontSize: 13 * fontScale)
        ],
      ),
    );
  }
}
