import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:lihkg_flutter/widget/message/image_view.dart';
// import 'package:lihkg_flutter/widget/message/clickable_image_view.dart';
import 'package:lihkg_flutter/widget/message/blockquote.dart';
// import 'package:lihkg_flutter/widget/message/code_syntax_highlighter.dart';
import 'package:lihkg_flutter/widget/message/url_handler.dart';
import 'package:lihkg_flutter/util/util.dart';

class LihkgWidgetFactory extends WidgetFactory {
  BuildContext context;

  LihkgWidgetFactory(this.context);

  // Temparary solution for supporting inline image
  // @override
  // Widget buildColumn(List<Widget> children) {
  //   return children?.isNotEmpty == true
  //       ? children?.length == 1
  //           ? Wrap(
  //               children: <Widget>[children.first],
  //               crossAxisAlignment: WrapCrossAlignment.center,
  //             )
  //           : Wrap(
  //               children: children,
  //               crossAxisAlignment: WrapCrossAlignment.center)
  //       : null;
  // }

  // @override
  // Widget buildBody(List<Widget> children) {
  //   return this.buildColumn(children);
  // }

  @override
  Widget buildImage(String src, {int height, String text, int width}) {
    return this.buildPadding(
        super.buildImage(src, height: height, text: text, width: width),
        EdgeInsets.symmetric(vertical: 5));
  }

  @override
  Widget buildImageFromUrl(String url) {
    if (url.contains('/assets/faces/')) {
      return SizedBox();
      // return ImageView(
      //     url: 'https://lihkg.com$url', compress: false, cacheAge: 100);
    } else {
      // return ClickableImageView(url: url);
      return ImageView(url: url);
    }
  }

  @override
  double buildTextFontSize(NodeMetadata meta, TextStyle parent) {
    final value = meta?.fontSize;
    if (value == null) return null;

    switch (value) {
      case kCssFontSizeXxLarge:
        return DefaultTextStyle.of(meta.context).style.fontSize + 8.0;
      case kCssFontSizeXLarge:
        return DefaultTextStyle.of(meta.context).style.fontSize + 7.0;
      case kCssFontSizeLarge:
        return DefaultTextStyle.of(meta.context).style.fontSize + 6.0;
      case kCssFontSizeMedium:
        return DefaultTextStyle.of(meta.context).style.fontSize + 5.0;
      case kCssFontSizeSmall:
        return DefaultTextStyle.of(meta.context).style.fontSize - 3.0;
      case kCssFontSizeXSmall:
        return DefaultTextStyle.of(meta.context).style.fontSize - 4.0;
      default:
        return DefaultTextStyle.of(meta.context).style.fontSize;
    }
  }

  @override
  NodeMetadata parseStyle(NodeMetadata meta, String key, String value) {
    meta = super.parseStyle(meta, key, value);
    switch (key) {
      case 'color':
        meta = lazySet(meta, color: supportedColor[value]);
        break;
    }
    return meta;
  }

  @override
  NodeMetadata parseElement(NodeMetadata meta, String tag) {
    final theme = Theme.of(context);
    switch (tag) {
      case 'a':
        meta = lazySet(meta,
            color: Colors.blue,
            decoUnder: false,
            buildOp: UrlHandler(wf: this).buildOp);
        break;
      case 'blockquote':
        meta = lazySet(meta, color: theme.hintColor, isBlockElement: true,
            buildOp: BuildOp(
          onWidgets: (meta, widgets) {
            return Blockquote(
                child: Column(
                    children: widgets,
                    crossAxisAlignment: CrossAxisAlignment.start));
          },
        ));
        break;
      case 'br':
        meta = lazySet(meta,
            buildOp: BuildOp(
                onWidgets: (meta, widgets) =>
                    this.buildColumn([Text('\u000D')]..addAll(widgets))));
        break;
      case 'code':
        meta = lazySet(meta, fontFamily: 'monospace', buildOp: BuildOp(
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
          onWidgets: (meta, widgets) {
            return Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: theme.primaryColorLight,
                    borderRadius: BorderRadius.circular(5)),
                child: Wrap(children: widgets));
          },
        ));
        break;
      case "img":
        meta = lazySet(meta, buildOp: BuildOp(onWidgets: (meta, widgets) {
          return this.buildImage(meta.domElement.attributes["src"]);
        }));
        break;
      case 'sub':
        meta = lazySet(meta, buildOp: BuildOp(onWidgets: (meta, widgets) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: theme.hintColor),
                borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            ),
          );
        }));
        break;
    }
    return meta;
  }
}
