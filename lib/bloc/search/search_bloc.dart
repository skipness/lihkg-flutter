import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/networking/api_client.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  String keyword;
  String sort;
  int page;

  SearchBloc({@required this.sort, this.page = 1});

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
        final items = await _search(event.text);
        yield SearchSuccess(
            items: items, hasReachedEnd: items.isEmpty ? true : false);
      } catch (_) {
        yield SearchError();
      }
    }

    if (event is Search && !_hasReachedEnd(currentState)) {
      try {
        if (currentState is SearchEmpty) {
          yield Searching();
          final items = await _search(event.text);
          yield SearchSuccess(
              items: items, hasReachedEnd: items.isEmpty ? true : false);
        }

        if (currentState is SearchSuccess) {
          page = page + 1;
          final items = await _search(event.text);
          yield items.isEmpty
              ? currentState.copyWith(hasReachedEnd: true)
              : SearchSuccess(
                  items: currentState.items + items, hasReachedEnd: false);
        }
      } catch (_) {
        yield SearchError();
      }
    }
  }

  bool _hasReachedEnd(SearchState state) =>
      state is SearchSuccess && state.hasReachedEnd;

  Future<List<Item>> _search(String text) async {
    final result = await ApiClient().search(text, page, sort, '1');
    if (result.errorCode == 100) {
      return [];
    } else {
      return result.response.items;
    }
  }
}
