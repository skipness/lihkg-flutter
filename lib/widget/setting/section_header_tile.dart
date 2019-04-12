import 'package:flutter/material.dart';

class SectionHeaderTile extends StatelessWidget {
  final String title;

  SectionHeaderTile({@required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
        enabled: false,
        title: Text('$title',
            style:
                theme.textTheme.subtitle.copyWith(color: theme.accentColor)));
  }
}
