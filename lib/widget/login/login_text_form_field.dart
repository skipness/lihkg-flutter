import 'package:flutter/material.dart';

typedef String Validator(String value);
typedef FormSubmittedCallBack(String value);
typedef FormSaveCallBack(String value);

class LiTextFormField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String hintText;
  final String helperText;
  final bool obscureText;
  final TextInputType keyboardType;
  // final TextChangedCallBack onTextChanged;
  final FormSaveCallBack onSaved;
  final FormSubmittedCallBack onFormSubmitted;
  // final TextEditingCompleteCallBack onTextEditingComplete;
  final Widget prefixIcon;
  final TextInputAction textInputAction;
  final Validator validator;

  LiTextFormField(
      {@required this.textEditingController,
      this.focusNode,
      this.hintText = '',
      this.helperText = '',
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onSaved,
      this.onFormSubmitted,
      this.prefixIcon,
      this.textInputAction = TextInputAction.unspecified,
      this.validator});

  @override
  _LiTextFormFieldState createState() => _LiTextFormFieldState();
}

class _LiTextFormFieldState extends State<LiTextFormField> {
  void _clearText() {
    widget.textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        maxLines: 1,
        autocorrect: false,
        obscureText: widget.obscureText,
        cursorColor: theme.cursorColor,
        keyboardType: widget.keyboardType,
        keyboardAppearance: theme.primaryColorBrightness,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFormSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: widget.prefixIcon,
          suffixIcon: IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(
                Icons.clear,
                color: theme.hintColor,
              ),
              onPressed: _clearText),
          hintText: widget.hintText,
          hintStyle: theme.textTheme.subtitle.copyWith(color: theme.hintColor),
          helperText: widget.helperText,
          helperStyle:
              theme.textTheme.subtitle.copyWith(color: theme.hintColor),
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
