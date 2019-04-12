import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        color: theme.backgroundColor,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(Icons.error_outline,
                      color: theme.iconTheme.color, size: 45)),
              Text('隊長我找不到屎',
                  style: theme.textTheme.subhead
                      .copyWith(fontWeight: FontWeight.bold))
            ])));
  }
}
