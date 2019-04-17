import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class SearchState extends Equatable {
  SearchState([List props = const []]) : super(props);
}

class SearchEmpty extends SearchState {
  @override
  String toString() => 'Search Empty';
}

class Searching extends SearchState {
  @override
  String toString() => 'Searching';
}

class SearchError extends SearchState {
  final String error;

  SearchError({@required this.error});

  @override
  String toString() => 'Search Error { error: $error }';
}

class SearchSuccess extends SearchState {
  final List<Item> items;
  final bool hasReachedEnd;

  SearchSuccess({this.items, this.hasReachedEnd})
      : super([items, hasReachedEnd]);

  SearchSuccess copyWith({bool hasReachedEnd}) {
    return SearchSuccess(
        items: items ?? this.items,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  @override
  String toString() =>
      'Search Success { items: $items, hasReachedEnd: $hasReachedEnd }\n';
}
