import 'package:flutter/material.dart';

class EmailText extends StatefulWidget {
  final String email;

  EmailText({@required this.email});

  @override
  _EmailTextState createState() => _EmailTextState();
}

class _EmailTextState extends State<EmailText> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => setState(() => hidden = !hidden),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          hidden
              ? Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: theme.primaryColorLight,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text('顯示註冊電郵',
                      style: theme.textTheme.subtitle
                          .copyWith(color: theme.hintColor)),
                )
              : Text('${widget.email}',
                  style:
                      theme.textTheme.subtitle.copyWith(color: theme.hintColor))
        ],
      ),
    );
  }
}
