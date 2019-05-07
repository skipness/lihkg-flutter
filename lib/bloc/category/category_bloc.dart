import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  final AuthenticationBloc authenticationBloc;
  int page = 1;

  CategoryBloc(
      {@required this.categoryRepository, @required this.authenticationBloc}) {
    dispatch(FetchCategory());
  }

  @override
  CategoryState get initialState => CategoryUninitialized();

  @override
  Stream<CategoryState> transform(Stream<CategoryEvent> events,
      Stream<CategoryState> Function(CategoryEvent event) next) {
    return super.transform(
        (events as Observable<CategoryEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is FetchCategory && !_hasReachedEnd(currentState)) {
      try {
        if (currentState is CategoryUninitialized) {
          final posts =
              await categoryRepository.fetchCategory(page, authenticationBloc);
          yield CategoryLoaded(items: posts, hasReachedEnd: false);
        }
        if (currentState is CategoryLoaded) {
          page = page + 1;
          final posts =
              await categoryRepository.fetchCategory(page, authenticationBloc);
          if (posts.isEmpty) {
            (currentState as CategoryLoaded).copyWith(hasReachedEnd: true);
          } else {
            final List<Item> newList =
                List.from((currentState as CategoryLoaded).items)
                  ..addAll(posts)
                  ..toSet().toList();
            yield CategoryLoaded(items: newList, hasReachedEnd: false);
          }
        }
      } catch (error) {
        yield CategoryError(error: error.toString());
      }
    }

    if (event is RefreshCategory) {
      try {
        page = 1;
        final posts =
            await categoryRepository.fetchCategory(page, authenticationBloc);
        yield CategoryLoaded(items: posts, hasReachedEnd: false);
      } catch (_) {
        yield currentState;
      }
    }
  }

  bool _hasReachedEnd(CategoryState state) =>
      state is CategoryLoaded && state.hasReachedEnd;
}
