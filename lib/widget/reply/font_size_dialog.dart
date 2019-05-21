import 'package:flutter/material.dart';
import 'package:lihkg_flutter/util/util.dart';

class FontSizeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
        backgroundColor: theme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: supportedFontSize.length,
              itemBuilder: (BuildContext context, int index) {
                final fontSize = supportedFontSize.values.toList()[index];
                return GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Text("Size $fontSize",
                            style: theme.textTheme.title.copyWith(
                                fontSize: theme.textTheme.title.fontSize *
                                    fontSize.toDouble() *
                                    0.5))),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(fontSize);
                  },
                );
              }),
        ));
  }
}
