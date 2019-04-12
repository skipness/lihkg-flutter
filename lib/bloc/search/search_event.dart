import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  SearchEvent([List props = const []]) : super(props);
}

class Search extends SearchEvent {
  String text;
  int page;

  Search({this.text, this.page}) : super([text, page]);

  @override
  String toString() => 'Search { text: $text, page: $page }';
}

class ResetSearch extends SearchEvent {
  String text;

  ResetSearch({this.text}) : super([text]);

  @override
  String toString() => 'Reset Search { text: $text }';
}
