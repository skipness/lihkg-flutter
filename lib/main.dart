import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/page/home.dart';
import 'package:lihkg_flutter/repository/repository.dart';

void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(BlocProviderTree(blocProviders: [
    BlocProvider<AuthenticationBloc>(
        bloc: AuthenticationBloc(meRepository: MeRepository())),
    BlocProvider<PreferenceBloc>(
        bloc: PreferenceBloc(
            sharedPreferences: await SharedPreferences.getInstance(),
            defaultPreferences: [
          Preference<bool>(key: DARK_THEME, initValue: false),
          Preference<double>(key: CAT_LIST_FONT_SIZE, initValue: 1),
          Preference<double>(key: THREAD_FONT_SIZE, initValue: 1),
          Preference<bool>(key: MEDIA_MODE_INCLUDE_LINK, initValue: false),
        ]))
  ], child: App()));
}

class App extends StatefulWidget {
  @override
  State createState() => _AppState();
}

class _AppState extends State<App> {
  AppBloc _appBloc;
  AuthenticationBloc _authenticationBloc;
  PreferenceBloc _preferenceBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _authenticationBloc.dispatch(AppStarted());
    _preferenceBloc.dispatch(GetPreference());
    _appBloc = AppBloc(
        appRepository: AppRepository(),
        authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  void dispose() {
    _appBloc.dispose();
    _authenticationBloc.dispose();
    _preferenceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceEvent, PreferenceState>(
      bloc: _preferenceBloc,
      builder: (BuildContext context, PreferenceState state) {
        return MaterialApp(
            theme: (state is PreferenceLoaded
                ? _preferenceBloc.getTheme(state.preferences[DARK_THEME].value)
                : _preferenceBloc.getTheme(false)),
            home: BlocBuilder<AppEvent, AppState>(
                bloc: _appBloc,
                builder: (BuildContext context, AppState state) {
                  if (state is AppUninitialized) {
                    final theme = Theme.of(context);
                    return Container(
                        color: theme.backgroundColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/logo.webp', height: 180),
                            const SizedBox(height: 50),
                            const CircularProgressIndicator(strokeWidth: 2)
                          ],
                        ));
                  }

                  if (state is AppError) {
                    final theme = Theme.of(context);
                    return Container(
                        color: theme.backgroundColor,
                        child: Center(child: Text('${state.error}')));
                  }

                  if (state is AppLoaded) {
                    final sysProps = state.systemProps;
                    return Home(sysPropsResponse: sysProps.sysPropsResponse);
                  }
                }));
      },
    );
  }
}
