import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:lihkg_flutter/widget/message/image_view.dart';
// import 'package:lihkg_flutter/widget/message/clickable_image_view.dart';
import 'package:lihkg_flutter/widget/message/blockquote.dart';
// import 'package:lihkg_flutter/widget/message/code_syntax_highlighter.dart';
import 'package:lihkg_flutter/widget/message/youtube.dart';
import 'package:lihkg_flutter/widget/message/twitter.dart';
import 'package:lihkg_flutter/widget/message/url_handler.dart';

class LihkgWidgetFactory extends WidgetFactory {
  final RegExp isYoutube = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$',
      caseSensitive: false);
  final RegExp isTwitter = RegExp(
      r'^https?:\/\/twitter\.com\/(?:#!\/)?(\w+)\/status(es)?\/(\d+)',
      caseSensitive: false);

  final _supportedColor = {
    'black': const Color(0xff000000),
    'red': const Color(0xffff0000),
    'green': const Color(0xff008000),
    'blue': const Color(0xff0000ff),
    'purple': const Color(0xff800080),
    'violet': const Color(0xffee82ee),
    'brown': const Color(0xffa52a2a),
    'pink': const Color(0xffffc0cb),
    'gold': const Color(0xffffd700),
    'maroon': const Color(0xff800000),
    'teal': const Color(0xff008080),
    'navy': const Color(0xff000080),
    'limegreen': const Color(0xff32cd32),
    'orange': const Color(0xffffa500)
  };

  final _supportedFotSize = {
    'xx-large': 8.0,
    'x-large': 7.0,
    'large': 6.0,
    'medium': 5.0,
    'small': -3.0,
    'x-small': -4.0,
  };

  LihkgWidgetFactory(BuildContext context) : super(context);

  // Temparary solution for supporting inline image
  @override
  Widget buildColumn(List<Widget> children) {
    return children?.isNotEmpty == true
        ? children?.length == 1
            ? Wrap(
                // key: UniqueKey(),
                children: <Widget>[children.first],
                crossAxisAlignment: WrapCrossAlignment.center,
              )
            // : Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: children,
            //     key: UniqueKey(),
            //   )
            : Wrap(
                // key: UniqueKey(),
                children: children,
                crossAxisAlignment: WrapCrossAlignment.center)
        : null;
  }

  @override
  Widget buildImageWidget(String src, {int height, int width}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: super.buildImageWidget(src, height: height, width: width),
    );
  }

  @override
  Widget buildImageWidgetFromUrl(String url) {
    if (url.contains('/assets/faces/')) {
      return ImageView(
          url: 'https://lihkg.com$url', compress: false, cacheAge: 100);
    } else {
      // return ClickableImageView(url: url);
      return ImageView(url: url);
    }
  }

  @override
  NodeMetadata parseElementStyle(NodeMetadata meta, String key, String value) {
    meta = super.parseElementStyle(meta, key, value);
    switch (key) {
      case 'font-size':
        meta = lazySet(meta,
            fontSize: DefaultTextStyle.of(context).style.fontSize +
                _supportedFotSize[value]);
        break;
      case 'color':
        meta = lazySet(meta, color: _supportedColor[value]);
        break;
    }
    return meta;
  }

  @override
  NodeMetadata parseElement(dom.Element element) {
    var meta = super.parseElement(element);
    final theme = Theme.of(context);
    switch (element.localName) {
      case 'a':
        meta = lazySet(meta,
            color: Colors.blue,
            buildOp: BuildOp(
                onPieces:
                    UrlHandler(fullUrl: element.attributes['href'], wf: this)
                        .onPieces,
                onWidgets: (widgets) {
                  String url = element.attributes['href'];
                  if (isYoutube.hasMatch(url)) {
                    return <Widget>[
                          Youtube(youtubeId: isYoutube.firstMatch(url).group(1))
                        ] +
                        widgets;
                  }
                  // else if (isTwitter.hasMatch(url)) {
                  //   return <Widget>[
                  //         Twitter(url: isTwitter.firstMatch(url).group(1))
                  //       ] +
                  //       widgets;
                  // }
                  return widgets;
                }));
        break;
      case 'br':
        meta = lazySet(meta,
            isBlockElement: true,
            textSpaceCollapse: false,
            buildOp: BuildOp(
                onWidgets: (widgets) => <Widget>[
                      const SizedBox(width: double.infinity),
                    ]));
        break;
      case 'code':
        meta = lazySet(meta, fontFamily: 'monospace', textSpaceCollapse: false,
            buildOp: BuildOp(
          // onPieces: (pieces) {
          //   List<BuiltPiece> newPieces = List();
          //   for (final piece in pieces) {
          //     if (piece.hasTextSpan) {
          //       newPieces.add(BuiltPieceSimple(
          //           textSpan: DartSyntaxHighlighter(
          //                   SyntaxHighlighterStyle.darkThemeStyle())
          //               .format(piece.text)));
          //     }
          //   }
          //   return newPieces;
          // },
          onWidgets: (widgets) {
            return <Widget>[
              Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: theme.primaryColorLight,
                      borderRadius: BorderRadius.circular(5)),
                  child: Wrap(children: widgets))
            ];
          },
        ));
        break;
      case 'blockquote':
        meta = lazySet(meta,
            color: theme.hintColor,
            buildOp: BuildOp(
              isBlockElement: true,
              onWidgets: (widgets) {
                return <Widget>[
                  Blockquote(
                      child: Column(
                          children: widgets,
                          crossAxisAlignment: CrossAxisAlignment.start))
                ];
              },
            ));
        break;
      case 'ins':
        meta = lazySet(meta, decorationUnderline: true);
        break;
      case 'del':
        meta = lazySet(meta, decorationLineThrough: true);
        break;
      case 'sub':
        meta = lazySet(meta, buildOp: BuildOp(onWidgets: (widgets) {
          return <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).hintColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              ),
            )
          ];
        }));
        break;
    }
    return meta;
  }
}
