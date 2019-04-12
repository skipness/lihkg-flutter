import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  final Widget child;

  ModalBottomSheet({@required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        color: theme.canvasColor,
        child: Container(
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(15.0),
                    topRight: const Radius.circular(15.0))),
            child: child));
  }
}
