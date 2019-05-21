import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:lihkg_flutter/widget/message/lihkg_widget_factory.dart';
// import 'package:lihkg_flutter/widget/message/twitter.dart';
import 'package:lihkg_flutter/widget/message/youtube.dart';

class UrlHandler {
  final LihkgWidgetFactory wf;
  final RegExp isYoutube = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$',
      caseSensitive: false);
  final RegExp isTwitter = RegExp(
      r'^https?:\/\/twitter\.com\/(?:#!\/)?(\w+)\/status(es)?\/(\d+)',
      caseSensitive: false);

  UrlHandler({@required this.wf});

  BuildOp get buildOp => BuildOp(onPieces: (meta, pieces) {
        final tap = _buildGestureTapCallback(meta);
        if (tap == null) return pieces;

        return pieces.map(
          (p) => p.hasWidgets
              ? BuiltPieceSimple(widgets: <Widget>[_buildGd(p.widgets, tap)])
              : _buildBlock(p, tap),
        );
      }, onWidgets: (meta, widgets) {
        String url = meta.domElement.attributes['href'];
        if (isYoutube.hasMatch(url)) {
          return wf.buildColumn([
            Youtube(youtubeId: isYoutube.firstMatch(url).group(1))
          ]..addAll(widgets.toList()));
        }
        return wf.buildColumn(widgets);
      });

  BuiltPiece _buildBlock(BuiltPiece piece, GestureTapCallback onTap) =>
      piece..block.rebuildBits((bit) => bit.rebuild(onTap: onTap));

  Widget _buildGd(List<Widget> widgets, GestureTapCallback onTap) =>
      wf.buildGestureDetector(wf.buildColumn(widgets), onTap);

  GestureTapCallback _buildGestureTapCallback(NodeMetadata meta) {
    final attrs = meta.domElement.attributes;
    final href = attrs.containsKey('href') ? attrs['href'] : '';
    final url = wf.constructFullUrl(href) ?? href;
    return wf.buildGestureTapCallbackForUrl(url);
  }
}
