import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository appRepository;
  final AuthenticationBloc authenticationBloc;

  AppBloc({@required this.appRepository, @required this.authenticationBloc})
      : assert(appRepository != null) {
    dispatch(FetchSysProps());
  }

  @override
  AppState get initialState => AppUninitialized();

  @override
  Stream<AppState> transform(
    Stream<AppEvent> events,
    Stream<AppState> Function(AppEvent event) next,
  ) {
    return super.transform(
        (events as Observable<AppEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is FetchSysProps) {
      try {
        if (currentState is AppUninitialized) {
          final sysProps =
              await appRepository.fetchSystemProps(authenticationBloc);
          yield AppLoaded(systemProps: sysProps);
        }
        // if (currentState is AppLoaded) {
        //   final posts = await _fetchCategory(page);

        // }
      } catch (error) {
        yield AppError(error: error.toString());
      }
    }
  }
}
