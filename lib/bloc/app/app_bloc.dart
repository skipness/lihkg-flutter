import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/networking/api_client.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() {
    dispatch(FetchSysProps());
  }

  @override
  AppState get initialState => AppUninitialized();

  @override
  Stream<AppEvent> transform(Stream<AppEvent> events) {
    return (events as Observable<AppEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<AppState> mapEventToState(
      AppState currentState, AppEvent event) async* {
    if (event is FetchSysProps) {
      try {
        if (currentState is AppUninitialized) {
          final sysProps = await _fetchSystemProps();
          yield AppLoaded(systemProps: sysProps);
        }
        // if (currentState is AppLoaded) {
        //   final posts = await _fetchCategory(page);

        // }
      } catch (_) {
        yield AppError();
      }
    }
  }

  Future<SysProps> _fetchSystemProps() async {
    try {
      return await ApiClient().fetchSysProps();
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
