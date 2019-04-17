import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class CategoryUninitialized extends CategoryState {
  @override
  String toString() => 'Category Uninitialized';
}

class CategoryError extends CategoryState {
  final String error;

  CategoryError({@required this.error});

  @override
  String toString() => 'Category Error { error: $error }';
}

class CategoryLoaded extends CategoryState {
  List<Item> items;
  final bool hasReachedEnd;

  CategoryLoaded({this.items, this.hasReachedEnd})
      : super([items, hasReachedEnd]);

  CategoryLoaded copyWith({List<Item> items, bool hasReachedEnd}) {
    return CategoryLoaded(
        items: items ?? this.items,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  @override
  String toString() =>
      'Category Loaded { posts: ${items.length}, hasReachedEnd: $hasReachedEnd }\n';
}
