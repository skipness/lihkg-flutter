import 'dart:async';

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
      text = text.replaceFirst(_linkifyRegex,
          '<a href=\"${match.group(0)}\">${match.group(0)}</a>');
    });
  }
  return text;
}
