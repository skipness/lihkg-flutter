import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart'
    show BuiltPiece, BuiltPieceSimple;
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/message/lihkg_widget_factory.dart';

class UrlHandler {
  final String fullUrl;
  final LihkgWidgetFactory wf;

  UrlHandler({@required this.fullUrl, @required this.wf});

  Widget buildGestureDetector(Widget child, GestureTapCallback onTap) =>
      child != null
          ? GestureDetector(
              onTap: onTap,
              child: Stack(
                children: <Widget>[
                  child,
                  buildGestureDetectorIcon(),
                ],
              ),
            )
          : null;

  Widget buildGestureDetectorIcon() => Positioned(
        top: 0.0,
        right: 0.0,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              Icons.open_in_new,
              color: Theme.of(wf.context).accentColor.withOpacity(.8),
              size: 40.0,
            )),
      );

  List<BuiltPiece> onPieces(List<BuiltPiece> pieces) {
    List<BuiltPiece> newPieces = List();

    final onTap = prepareGestureTapCallback(fullUrl.trim());
    final recognizer = TapGestureRecognizer()..onTap = onTap;

    for (final piece in pieces) {
      if (piece.hasTextSpan) {
        newPieces.add(BuiltPieceSimple(
          textSpan: rebuildTextSpanWithRecognizer(piece.textSpan, recognizer),
        ));
      } else if (piece.hasText) {
        newPieces.add(BuiltPieceSimple(
          textSpan: TextSpan(text: piece.text.trim(), recognizer: recognizer),
        ));
      } else if (piece.hasWidgets) {
        final gd = buildGestureDetector(wf.buildColumn(piece.widgets), onTap);
        if (gd != null) {
          newPieces.add(BuiltPieceSimple(widgets: <Widget>[gd]));
        }
      }
    }

    return newPieces;
  }

  GestureTapCallback prepareGestureTapCallback(String url) => () {
        InAppBrowser browser = InAppBrowser(context: wf.context);
        browser.open(url: url);
      };

// this is required because recognizer does not trigger for children
  // https://github.com/flutter/flutter/issues/10623
  TextSpan rebuildTextSpanWithRecognizer(TextSpan span, GestureRecognizer r) =>
      TextSpan(
        children: span?.children == null
            ? null
            : span.children
                .map((TextSpan subSpan) =>
                    rebuildTextSpanWithRecognizer(subSpan, r))
                .toList(),
        style: span?.style,
        recognizer: r,
        text: span?.text?.trim(),
      );
}
