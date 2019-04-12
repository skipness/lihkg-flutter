import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';

class MediaIncLinkTile extends StatefulWidget {
  @override
  State createState() => _MediaIncLinkTileState();
}

class _MediaIncLinkTileState extends State<MediaIncLinkTile> {
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
                  ? state.preferences[MEDIA_MODE_INCLUDE_LINK].value
                  : false),
              title: Text('多媒體模式包含圖片連結'),
              subtitle: Text('可能會出現Bam圖',
                  style: theme.textTheme.subtitle
                      .copyWith(color: theme.hintColor)),
              activeColor: theme.accentColor,
              inactiveTrackColor: theme.dividerColor,
              onChanged: (value) {
                var state = _preferenceBloc.currentState;
                if (state is PreferenceLoaded) {
                  var pref = state.preferences[MEDIA_MODE_INCLUDE_LINK];
                  pref.value = value;
                  _preferenceBloc.dispatch(SetPreference(preference: pref));
                }
              });
        });
  }
}
