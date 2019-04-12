import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

class ThreadTitle extends StatefulWidget {
  final String title;
  ThreadTitle({@required this.title});

  @override
  State createState() => _ThreadTitleState();
}

class _ThreadTitleState extends State<ThreadTitle> {
  @override
  @override
  Widget build(BuildContext context) {
    final double fontScale = PreferenceContext.of(context).preference;
    return Text(
      widget.title,
      softWrap: true,
      style: TextStyle(fontSize: 16 * fontScale),
    );
  }
}
