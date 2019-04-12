import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class InAppBrowser {
  final BuildContext context;
  final ChromeSafariBrowser browser = ChromeSafariBrowser(null);

  InAppBrowser({@required this.context});

  void open({@required url}) {
    final theme = Theme.of(context);
    final backgroundHex = theme.primaryColor.value.toRadixString(16);
    final accentHex = theme.accentColor.value.toRadixString(16);
    browser.open(url, options: {
      'enableUrlBarHiding': true,
      'toolbarBackgroundColor':
          '#${backgroundHex.substring(2, backgroundHex.length)}',
      'barCollapsingEnabled': true,
      'preferredBarTintColor':
          '#${backgroundHex.substring(2, backgroundHex.length)}',
      'preferredControlTintColor':
          '#${accentHex.substring(2, accentHex.length)}'
    });
  }
}
