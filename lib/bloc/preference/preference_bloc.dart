import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/theme/dark_theme.dart';
import 'package:lihkg_flutter/theme/light_theme.dart';

const DARK_THEME = 'DARK_THEME';
const CAT_LIST_FONT_SIZE = 'CAT_LIST_FONT_SIZE';
const THREAD_FONT_SIZE = 'THREAD_FONT_SIZE';
const SHOULD_AUTO_LOAD_IMAGE = 'SHOULD_AUTO_LOAD_IMAGE';
const MEDIA_MODE_INCLUDE_LINK = 'MEDIA_MODE_INCLUDE_LINK';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  final SharedPreferences sharedPreferences;
  final List<Preference> defaultPreferences;

  PreferenceBloc(
      {@required this.sharedPreferences, @required this.defaultPreferences});

  @override
  PreferenceState get initialState => PreferenceLoading();

  @override
  Stream<PreferenceState> mapEventToState(
      PreferenceState currentState, PreferenceEvent event) async* {
    if (event is GetPreference) {
      try {
        if (event is GetPreference) {
          var preferencesMap = Map<String, Preference>();
          defaultPreferences
              .map((preference) => _getPreference(preference))
              .forEach(
                  (preference) => preferencesMap[preference.key] = preference);
          yield PreferenceLoaded(preferences: preferencesMap);
        }
      } catch (_) {
        yield PreferenceError();
      }
    }

    if (event is SetPreference) {
      try {
        yield PreferenceLoading();
        await _setPreference(event.preference);
        dispatch(GetPreference());
      } catch (_) {
        yield PreferenceError();
      }
    }
  }

  Preference _getPreference(Preference preference) {
    switch (preference.typeOfPreference()) {
      case int:
        preference.value = sharedPreferences.getInt(preference.key);
        break;
      case double:
        preference.value = sharedPreferences.getDouble(preference.key);
        break;
      case bool:
        preference.value = sharedPreferences.getBool(preference.key);
        break;
      case String:
        preference.value = sharedPreferences.getString(preference.key);
        break;
      case List:
        preference.value = sharedPreferences.getStringList(preference.key);
        break;
      default:
        throw Exception('Preference Type Error');
    }

    if (preference.value == null) {
      preference.value = preference.initValue;
    }
    return preference;
  }

  Future _setPreference(Preference preference) async {
    switch (preference.typeOfPreference()) {
      case int:
        await sharedPreferences.setInt(preference.key, preference.value);
        break;
      case double:
        await sharedPreferences.setDouble(preference.key, preference.value);
        break;
      case bool:
        await sharedPreferences.setBool(preference.key, preference.value);
        break;
      case String:
        await sharedPreferences.setString(preference.key, preference.value);
        break;
      case List:
        await sharedPreferences.setStringList(preference.key, preference.value);
        break;
      default:
        throw Exception('Preference Type Error');
    }
  }

  ThemeData getTheme(bool value) {
    return value ? darkTheme : lightTheme;
  }
}
