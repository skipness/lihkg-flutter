import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class Youtube extends StatefulWidget {
  final String youtubeId;

  Youtube({this.youtubeId});

  @override
  State createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  build(BuildContext context) {
    final backgroundColorHex =
        Theme.of(context).backgroundColor.value.toRadixString(16);
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: InAppWebView(
        initialData: InAppWebViewInitialData('<html>'
            '<meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0, user-scalable=no">'
            '<body style="background-color:${backgroundColorHex.substring(2, backgroundColorHex.length)}"><div style="height:100%;"><div style="display:block;position:absolute;width:100%;height:0;padding-top:56.25%;margin-top:-28.1%;top:50%;left:0;right:0;"><iframe scrolling="no" frameborder="0" allowfullscreen style="display:block;position:absolute;left:0;top:0;right:0;bottom:0;width:100%;height:100%" src="https://www.youtube.com/embed/${widget.youtubeId}"></iframe></div></div></body>'
            '</html>'),
        initialOptions: {
          'allowsLinkPreview': false,
          'allowsBackForwardNavigationGestures': false,
        },
      ),
    );
  }
}
