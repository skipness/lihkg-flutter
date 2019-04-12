import 'package:flutter/material.dart';

class ReplyPage extends StatefulWidget {
  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: theme.backgroundColor,
        child: SafeArea(
          child: TextField(
            
          ),
        ),
      ),
    );
  }
}