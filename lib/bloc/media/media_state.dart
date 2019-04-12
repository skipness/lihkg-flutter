import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

abstract class MediaState extends Equatable {
  MediaState([List props = const []]) : super(props);
}

class MediaUninitialized extends MediaState {
  @override
  String toString() => 'Media Uninitialized';
}

class MediaError extends MediaState {
  @override
  String toString() => 'Media Error';
}

class MediaLoaded extends MediaState {
  final List<MediaContent> items;

  MediaLoaded({this.items}) : super([items]);

  @override
  String toString() => 'Media Loaded { items: $items }\n';
}
