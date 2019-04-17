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
