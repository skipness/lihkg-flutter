import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {}

class FetchCategory extends CategoryEvent {
  @override
  String toString() => 'Fetch Category';
}

class RefreshCategory extends CategoryEvent {
  @override
  String toString() => 'Refresh Category';
}
