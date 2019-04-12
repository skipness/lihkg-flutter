import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/networking/api_client.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  SubCategory subCategory;
  int page = 1;

  CategoryBloc({@required this.subCategory}) {
    dispatch(FetchCategory());
  }

  @override
  CategoryState get initialState => CategoryUninitialized();

  @override
  Stream<CategoryEvent> transform(Stream<CategoryEvent> events) {
    return (events as Observable<CategoryEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<CategoryState> mapEventToState(
      CategoryState currentState, CategoryEvent event) async* {
    if (event is FetchCategory && !_hasReachedEnd(currentState)) {
      try {
        if (currentState is CategoryUninitialized) {
          final posts = await _fetchCategory(page);
          print(posts.first.toString());
          yield CategoryLoaded(items: posts, hasReachedEnd: false);
        }

        if (currentState is CategoryLoaded) {
          page = page + 1;
          final posts = await _fetchCategory(page);
          if (posts.isEmpty) {
            currentState.copyWith(hasReachedEnd: true);
          } else {
            final List<Item> newList = List.from(currentState.items)
              ..addAll(posts)
              ..toSet().toList();
            yield CategoryLoaded(items: newList, hasReachedEnd: false);
          }
        }
      } catch (_) {
        yield CategoryError();
      }
    }

    if (event is RefreshCategory) {
      try {
        page = 1;
        final posts = await _fetchCategory(page);
        yield CategoryLoaded(items: posts, hasReachedEnd: false);
      } catch (_) {
        yield currentState;
      }
    }
  }

  bool _hasReachedEnd(CategoryState state) =>
      state is CategoryLoaded && state.hasReachedEnd;

  Future<List<Item>> _fetchCategory(int page) async {
    try {
      final url = this.subCategory.url;
      final query = this.subCategory.query.toJson();
      final result = await ApiClient()
          .fetchCategory(url, this.subCategory.catId, page, query: query);
      if (result.errorCode == 100) {
        return [];
      } else {
        return result.response.items;
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
