import 'package:flutter/material.dart';

typedef void TextChangedCallBack(String text);
typedef void TextSubmittedCallBack(String text);
typedef void TextEditingCompleteCallBack();

class LiTextField extends StatefulWidget {
  final int maxLines;
  final String hintText;
  final TextInputType keyboardType;
  final TextChangedCallBack onTextChanged;
  final TextSubmittedCallBack onTextSubmitted;
  final TextEditingCompleteCallBack onTextEditingComplete;
  final TextInputAction textInputAction;

  LiTextField(
      {this.maxLines = 1,
      this.hintText = '',
      this.keyboardType = TextInputType.text,
      this.onTextChanged,
      this.onTextSubmitted,
      this.onTextEditingComplete,
      this.textInputAction = TextInputAction.unspecified});

  @override
  State createState() => _LiTextFieldState();
}

class _LiTextFieldState extends State<LiTextField> {
  final _textEditingController = TextEditingController();

  void _clearText() {
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
        controller: _textEditingController,
        maxLines: widget.maxLines,
        autocorrect: false,
        cursorColor: theme.cursorColor,
        keyboardType: widget.keyboardType,
        keyboardAppearance: theme.primaryColorBrightness,
        textInputAction: widget.textInputAction,
        onChanged: widget.onTextChanged,
        onSubmitted: widget.onTextSubmitted,
        onEditingComplete: widget.onTextEditingComplete,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(
                Icons.clear,
                color: theme.iconTheme.color,
              ),
              onPressed: _clearText),
          hintText: widget.hintText,
          hintStyle: theme.textTheme.subtitle.copyWith(color: theme.hintColor),
          hintMaxLines: 1,
          filled: true,
          fillColor: theme.dividerColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              )),
        ));
  }
}
