import 'package:flutter/material.dart';

class PersistenceTabview extends StatefulWidget {
  final Widget child;

  PersistenceTabview({Key key, @required this.child}) : super(key: key);

  State createState() => _PersistenceTabviewState();
}

class _PersistenceTabviewState extends State<PersistenceTabview>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
