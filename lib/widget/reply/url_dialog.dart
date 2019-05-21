import 'package:flutter/material.dart';

class UrlDialog extends StatefulWidget {
  @override
  _UrlDialogState createState() => _UrlDialogState();
}

class _UrlDialogState extends State<UrlDialog> {
  String url = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autocorrect: false,
                autofocus: true,
                cursorColor: theme.accentColor,
                keyboardAppearance: theme.primaryColorBrightness,
                keyboardType: TextInputType.url,
                maxLines: 1,
                textInputAction: TextInputAction.unspecified,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: theme.accentColor),
                    ),
                    hintText: "輸入網址"),
                onChanged: (text) {
                  setState(() => url = text);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 18, right: 20),
                    child: GestureDetector(
                        child: Text(
                          "取消",
                          style: theme.textTheme.button,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: GestureDetector(
                        child: Text(
                          "插入網址",
                          style: theme.textTheme.button,
                        ),
                        onTap: () {
                          Navigator.of(context).pop(url);
                        }),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
