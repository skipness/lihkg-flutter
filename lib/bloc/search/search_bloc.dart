import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;
  AuthenticationBloc authenticationBloc;
  int page;

  SearchBloc(
      {@required this.searchRepository,
      @required this.authenticationBloc,
      this.page = 1});

  @override
  SearchState get initialState => SearchEmpty();

  @override
  Stream<SearchEvent> transform(Stream<SearchEvent> events) {
    return (events as Observable<SearchEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<SearchState> mapEventToState(
      SearchState currentState, SearchEvent event) async* {
    if (event is ResetSearch) {
      try {
        page = 1;
        yield Searching();
        final items =
            await searchRepository.search(event.text, page, authenticationBloc);
        yield SearchSuccess(
            items: items, hasReachedEnd: items.isEmpty ? true : false);
      } catch (error) {
        yield SearchError(error: error.toString());
      }
    }

    if (event is Search && !_hasReachedEnd(currentState)) {
      try {
        if (currentState is SearchEmpty) {
          yield Searching();
          final items = await searchRepository.search(
              event.text, page, authenticationBloc);
          yield SearchSuccess(
              items: items, hasReachedEnd: items.isEmpty ? true : false);
        }

        if (currentState is SearchSuccess) {
          page = page + 1;
          final items = await searchRepository.search(
              event.text, page, authenticationBloc);
          yield items.isEmpty
              ? currentState.copyWith(hasReachedEnd: true)
              : SearchSuccess(
                  items: currentState.items + items, hasReachedEnd: false);
        }
      } catch (error) {
        yield SearchError(error: error.toString());
      }
    }
  }

  bool _hasReachedEnd(SearchState state) =>
      state is SearchSuccess && state.hasReachedEnd;
}
