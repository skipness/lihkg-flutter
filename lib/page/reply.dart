import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/thread_model.dart';
import 'package:lihkg_flutter/widget/reply/input_accessary.dart';

class ReplyPage extends StatefulWidget {
  final String title;
  final ThreadItem quote;

  ReplyPage({@required this.title, this.quote});

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  ThreadActionBloc _threadActionBloc;
  TextEditingController textEditingController;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _threadActionBloc = BlocProvider.of<ThreadActionBloc>(context);
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(
              builder: (BuildContext context) => FlatButton(
                    child: Text('發送', style: theme.textTheme.button),
                    onPressed: () {
                      if (textEditingController.text.trim().isEmpty) {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('回覆不能為空白')));
                      } else {
                        _threadActionBloc.dispatch(ReplyThread(
                            threadId:
                                _threadActionBloc.threadRepository.threadId,
                            content: textEditingController.text,
                            quoteId: widget.quote.postId));
                        Navigator.of(context).pop();
                      }
                    },
                  )),
        ],
      ),
      body: Container(
        color: theme.backgroundColor,
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                autocorrect: false,
                controller: textEditingController,
                cursorColor: theme.accentColor,
                focusNode: _focusNode,
                keyboardType: TextInputType.multiline,
                keyboardAppearance: theme.primaryColorBrightness,
                maxLength: 4000,
                maxLines: null,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    counter: null,
                    counterText: null,
                    hintText: "是咁的⋯⋯",
                    hintStyle: theme.textTheme.subhead
                        .copyWith(color: theme.hintColor)),
              ),
            ),
            InputAccessary(controller: textEditingController)
          ],
        )),
      ),
    );
  }
}
