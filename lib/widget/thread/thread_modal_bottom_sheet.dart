import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';

typedef VoidCallback OnPageChange(int page);

class ThreadModalBottomSheet extends StatelessWidget {
  final ScrollController scrollController;
  final int currentPage;
  final OnPageChange onPageChange;

  ThreadModalBottomSheet(
      {@required this.currentPage,
      @required this.onPageChange,
      @required this.scrollController});

  Widget _buildInfoRow() => Builder(builder: (BuildContext context) {
        final _threadBloc = BlocProvider.of<ThreadBloc>(context);
        final theme = Theme.of(context);
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(children: <Widget>[
              Text(_threadBloc.thread.category.name,
                  style: theme.textTheme.subhead),
              const Spacer(),
              IconButton(
                  icon:
                      Icon(Icons.arrow_downward, color: theme.iconTheme.color),
                  onPressed: () {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.decelerate);
                  })
            ]));
      });

  Widget _buildListView() => Builder(builder: (BuildContext context) {
        final _threadBloc = BlocProvider.of<ThreadBloc>(context);
        final theme = Theme.of(context);
        return Expanded(
          child: ListView.builder(
              itemCount: _threadBloc.thread.totalPage ?? 1,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text('第${index + 1}頁',
                        style: theme.textTheme.subhead.copyWith(
                            color: index + 1 == currentPage
                                ? theme.accentColor
                                : theme.hintColor)),
                    onTap: () {
                      if (currentPage == index + 1) return;
                      onPageChange(index + 1);
                      _threadBloc.dispatch(ChangePage(page: index + 1));
                      Navigator.of(context).pop();
                    });
              },
              physics: theme.platform == TargetPlatform.iOS
                  ? const BouncingScrollPhysics()
                  : const ClampingScrollPhysics(),
              controller: scrollController),
        );
      });

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[_buildInfoRow(), _buildListView()]));
  }
}
