import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/reply/url_dialog.dart';
import 'package:lihkg_flutter/widget/reply/color_dialog.dart';
import 'package:lihkg_flutter/widget/reply/font_size_dialog.dart';

class InputAccessary extends StatelessWidget {
  final TextEditingController controller;

  InputAccessary({@required this.controller});

  void insert(String text, int offset, {TextSelection textSelection}) {
    final selection = textSelection ?? controller.selection;
    final prefix = controller.text.substring(0, selection.baseOffset);
    final suffix = controller.text.substring(selection.baseOffset);
    controller.value = controller.value.copyWith(
        text: prefix + text + suffix,
        selection:
            TextSelection.collapsed(offset: selection.baseOffset + offset),
        composing: TextRange.empty);
  }

  IconButton button(Widget icon, VoidCallback onPressed) => IconButton(
        icon: icon,
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Ink(
      color: theme.primaryColorDark,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            button(Icon(Icons.format_size), () async {
              final selection = controller.selection;
              int fontSize = await showDialog(
                  context: context,
                  builder: (BuildContext context) => FontSizeDialog());
              if (fontSize != null) {
                insert("[size=$fontSize][/size=$fontSize]", 8,
                    textSelection: selection);
              } else {
                controller.selection = selection;
              }
            }),
            button(Icon(Icons.format_color_fill), () async {
              final selection = controller.selection;
              String color = await showDialog(
                  context: context,
                  builder: (BuildContext context) => ColorDialog());
              if (color != null) {
                insert("[$color][/$color]", 2 + color.length,
                    textSelection: selection);
              } else {
                controller.selection = selection;
              }
            }),
            button(Icon(Icons.image), () {}),
            button(Icon(Icons.link), () async {
              final selection = controller.selection;
              String url = await showDialog(
                  context: context,
                  builder: (BuildContext context) => UrlDialog());
              if (url != null) {
                insert("[url]$url[/url]", 11 + url.length,
                    textSelection: selection);
              } else {
                controller.selection = selection;
              }
            }),
            button(Icon(Icons.format_bold), () => insert("[b][/b]", 3)),
            button(
                Icon(Icons.format_strikethrough), () => insert("[s][/s]", 3)),
            button(Icon(Icons.format_underlined), () => insert("[u][/u]", 3)),
            button(Icon(Icons.format_italic), () => insert("[i][/i]", 3)),
            button(
                Icon(Icons.format_quote), () => insert("[quote][/quote]", 7)),
            button(Icon(Icons.code), () => insert("```\n\n```", 4)),
            button(Icon(Icons.format_align_left),
                () => insert("[left][/left]", 6)),
            button(Icon(Icons.format_align_center),
                () => insert("[center][/center]", 8)),
            button(Icon(Icons.format_align_right),
                () => insert("[right][/right]", 7)),
            button(Icon(Icons.lock), () => insert("[member][/member]", 8))
          ],
        ),
      ),
    );
  }
}
