import 'package:flutter/material.dart';

class Blockquote extends StatelessWidget {
  final Widget child;

  const Blockquote({this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: theme.hintColor, width: 2))),
      child: child == null ? const SizedBox() : child,
    );
  }
}
