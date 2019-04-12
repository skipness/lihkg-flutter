import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class Twitter extends StatefulWidget {
  final String url;

  Twitter({this.url});

  @override
  State createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  build(BuildContext context) {
    final backgroundColorHex =
        Theme.of(context).backgroundColor.value.toRadixString(16);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: InAppWebView(
        initialData: InAppWebViewInitialData('<html>'
            '<meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0, user-scalable=no">'
            '<body style="background-color:${backgroundColorHex.substring(2, backgroundColorHex.length)}"><a class="twitter-timeline" data-height="200" data-theme="dark" href="https://twitter.com/ChiefPentSpox?ref_src=twsrc%5Etfw">Tweets by ChiefPentSpox</a> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script></body>'
            '</html>'),
        initialOptions: {
          'allowsLinkPreview': false,
          'allowsBackForwardNavigationGestures': false,
          'enableViewportScale': true,
        },
      ),
    );
  }
}
