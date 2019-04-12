import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

class PageNumber extends StatelessWidget {
  final String messageNumber;

  const PageNumber({@required this.messageNumber});

  @override
  Widget build(BuildContext context) {
    final fontScale = PreferenceContext.of(context).preference;
    final theme = Theme.of(context);
    return Container(
      color: theme.backgroundColor,
      height: 50,
      child: Center(
        child: Text('第${(int.parse(messageNumber) / 25).ceil()}頁',
            style: theme.textTheme.title.copyWith(
                color: theme.hintColor,
                fontSize: theme.textTheme.subhead.fontSize * fontScale)),
      ),
    );
  }
}
