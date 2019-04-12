import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/message/blockquote.dart';
import 'package:lihkg_flutter/widget/message/lihkg_widget_factory.dart';
import 'package:lihkg_flutter/util/util.dart';

class ThreadMessage extends StatelessWidget {
  final ThreadItem threadItem;
  final isQuote;

  const ThreadMessage({@required this.threadItem, this.isQuote = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontScale = PreferenceContext.of(context).preference;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          threadItem.quote != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Blockquote(
                      child: ThreadMessage(
                    threadItem: threadItem.quote,
                    isQuote: true,
                  )))
              : const SizedBox(),
          threadItem.status == "1"
              ? DefaultTextStyle(
                  style: theme.textTheme.body1.merge(TextStyle(
                      letterSpacing: 0.95,
                      height: 1.1,
                      fontSize: 17 * fontScale,
                      color: isQuote
                          ? theme.hintColor
                          : theme.textTheme.body1.color)),
                  child: HtmlWidget(linkify(threadItem.msg),
                      wfBuilder: (context) => LihkgWidgetFactory(context)))
              : Center(
                  child: Text('回覆#${threadItem.msgNum}已被移除',
                      style: theme.textTheme.subtitle.copyWith(
                          color: theme.hintColor, fontWeight: FontWeight.bold)))
        ]);
  }
}
