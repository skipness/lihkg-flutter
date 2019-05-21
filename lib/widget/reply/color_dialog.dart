import 'package:flutter/material.dart';
import 'package:lihkg_flutter/util/util.dart';

class ColorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
        backgroundColor: theme.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.2,
                crossAxisCount: 4,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
              ),
              itemCount: supportedColor.length,
              itemBuilder: (BuildContext context, int index) {
                final color = supportedColor.values.toList()[index];
                return GestureDetector(
                  child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      )),
                  onTap: () {
                    Navigator.of(context)
                        .pop(supportedColor.keys.toList()[index]);
                  },
                );
              }),
        ));
  }
}
