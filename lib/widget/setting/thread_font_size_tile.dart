import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';

class ThreadFontSizeTile extends StatefulWidget {
  @override
  State createState() => _ThreadFontSizeTileState();
}

class _ThreadFontSizeTileState extends State<ThreadFontSizeTile> {
  PreferenceBloc _preferenceBloc;

  @override
  void initState() {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
        title: Text('字體大小'),
        // leading: Icon(Icons.format_size, color: theme.iconTheme.color),
        trailing: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[Text('最細'), Text('中'), Text('最大')],
                  ),
                  BlocBuilder(
                      bloc: _preferenceBloc,
                      builder: (BuildContext context, PreferenceState state) {
                        return Slider(
                            min: 0.8,
                            max: 1.2,
                            activeColor: theme.accentColor,
                            inactiveColor: theme.dividerColor,
                            value: (state is PreferenceLoaded
                                ? state.preferences[THREAD_FONT_SIZE].value
                                : 1),
                            divisions: 4,
                            onChanged: (value) {
                              var state = _preferenceBloc.currentState;
                              if (state is PreferenceLoaded) {
                                var pref = state.preferences[THREAD_FONT_SIZE];
                                pref.value = value;
                                _preferenceBloc
                                    .dispatch(SetPreference(preference: pref));
                              }
                            });
                      })
                ])));
  }
}
