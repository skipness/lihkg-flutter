import 'dart:async';
import 'package:flutter/material.dart';

typedef Future<List<T>> PageRequest<T>(String catId, int page, String threadId);

final _linkifyRegex = RegExp(
    r'(?![^<]*>|[^<>]*<\/)((https?:)\/\/[a-z0-9&#=.\/\-?_]+)',
    caseSensitive: false);

String timeStringBuilder(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);

  if (diff.inDays > 365) return "${(diff.inDays / 365).floor()}y";
  if (diff.inDays > 30) return "${(diff.inDays / 30).floor()}m";
  if (diff.inDays > 7) return "${(diff.inDays / 7).floor()}w";
  if (diff.inDays > 0) return "${diff.inDays}d";
  if (diff.inHours > 0) return "${diff.inHours}h";
  if (diff.inMinutes > 0) return "${diff.inMinutes}m";
  if (diff.inSeconds > 0) return "${diff.inSeconds}s";
  return "剛剛";
}

String linkify(String text) {
  final match = _linkifyRegex.allMatches(text);
  if (match == null) {
    return text;
  } else {
    match.forEach((Match match) {
      text = text.replaceFirst(
          _linkifyRegex, '<a href=\"${match.group(0)}\">${match.group(0)}</a>');
    });
  }
  return text;
}

final Map<String, Color> supportedColor = {
  'red': Color(0xffff0000),
  'green': Color(0xff008000),
  'blue': Color(0xff0000ff),
  'purple': Color(0xff800080),
  'violet': Color(0xffee82ee),
  'brown': Color(0xffa52a2a),
  'pink': Color(0xffffc0cb),
  'gold': Color(0xffffd700),
  'maroon': Color(0xff800000),
  'teal': Color(0xff008080),
  'navy': Color(0xff000080),
  'limegreen': Color(0xff32cd32),
  'orange': Color(0xffffa500)
};

final Map<String, int> supportedFontSize = {
  'xx-large': 6,
  'x-large': 5,
  'large': 4,
  'medium': 3,
  'small': 2,
  'x-small': 1,
};
