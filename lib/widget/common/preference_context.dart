import 'package:flutter/material.dart';

class PreferenceContext extends InheritedWidget {
  final dynamic preference;

  PreferenceContext({
    Key key,
    @required this.preference,
    @required Widget child,
  }) : super(key: key, child: child);

  static PreferenceContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(PreferenceContext);
  }

  @override
  bool updateShouldNotify(PreferenceContext oldWidget) {
    return preference != oldWidget.preference;
  }
}
