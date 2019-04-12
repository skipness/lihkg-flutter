import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';

class DarkModeTile extends StatefulWidget {
  @override
  State createState() => _DarkModeTileState();
}

class _DarkModeTileState extends State<DarkModeTile> {
  PreferenceBloc _preferenceBloc;

  @override
  void initState() {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PreferenceEvent, PreferenceState>(
        bloc: _preferenceBloc,
        builder: (BuildContext context, PreferenceState state) {
          return SwitchListTile(
              value: (state is PreferenceLoaded
                  ? state.preferences[DARK_THEME].value
                  : false),
              title: Text('黑夜模式'),
              activeColor: theme.accentColor,
              inactiveTrackColor: theme.dividerColor,
              onChanged: (value) {
                var state = _preferenceBloc.currentState;
                if (state is PreferenceLoaded) {
                  var pref = state.preferences[DARK_THEME];
                  pref.value = value;
                  _preferenceBloc.dispatch(SetPreference(preference: pref));
                }
              });
        });
  }
}
