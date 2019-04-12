import 'package:flutter/material.dart';

typedef Widget ListCell(dynamic t);
typedef Widget ListFooter(bool b);

class LiListView extends StatefulWidget {
  final List items;
  final ListCell cell;
  final ListFooter footer;
  final ScrollController scrollController;
  final bool showScrollBar;
  final bool hasReachedEnd;
  final bool canRefresh;
  final VoidCallback loadMore;
  final VoidCallback refresh;

  LiListView(
      {Key key,
      this.items,
      this.cell,
      this.footer,
      this.scrollController,
      this.showScrollBar,
      this.hasReachedEnd,
      this.canRefresh = true,
      this.loadMore,
      this.refresh})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LiListViewState();
}

class _LiListViewState extends State<LiListView> {
  @override
  void initState() {
    // widget.scrollController.addListener(() {
    //   final maxScroll = widget.scrollController.position.maxScrollExtent;
    //   final currentScroll = widget.scrollController.position.pixels;
    //   if (maxScroll - currentScroll <= 200) {
    //     widget.loadMore();
    //   }
    // });
    super.initState();
  }

  Widget _listView(ThemeData theme) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.maxScrollExtent -
                scrollNotification.metrics.pixels <=
            200) {
          widget.loadMore();
        }
      },
      child: ListView.builder(
          key: widget.key,
          itemCount: widget.items.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return index >= widget.items.length
                ? widget.footer(widget.hasReachedEnd)
                : widget.cell(widget.items[index]);
          },
          // controller: widget.scrollController,
          physics: theme.platform == TargetPlatform.iOS
              ? const BouncingScrollPhysics(
                  parent: const AlwaysScrollableScrollPhysics())
              : const ClampingScrollPhysics()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        color: theme.backgroundColor,
        child: SafeArea(
            bottom: false,
            child: RefreshIndicator(
                notificationPredicate: (scrollNotification) {
                  return widget.canRefresh ? true : false;
                },
                backgroundColor: theme.primaryColor,
                onRefresh: widget.refresh,
                child: widget.showScrollBar
                    ? Scrollbar(child: _listView(theme))
                    : _listView(theme))));
  }
}
