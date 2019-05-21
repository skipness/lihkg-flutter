import 'package:flutter/material.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/category/category_cell/category_cell.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/page/thread.dart';

class ThreadListCell extends StatelessWidget {
  final String currentCatId;
  final Item thread;

  const ThreadListCell(
      {Key key, @required this.thread, @required this.currentCatId})
      : super(key: key);

  Widget buildLeftContainer() =>
      Expanded(child: Builder(builder: (BuildContext context) {
        final theme = Theme.of(context);
        final double fontScale = PreferenceContext.of(context).preference;
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              thread.isHot
                  ? Expanded(
                      child: Icon(Icons.trending_up,
                          size: 13 * fontScale, color: theme.accentColor),
                    )
                  : SizedBox(),
              thread.isReplied
                  ? Expanded(
                      child: Icon(Icons.reply,
                          size: 13 * fontScale, color: theme.hintColor),
                    )
                  : SizedBox(), // Expanded(child: const SizedBox()),
              thread.isBookmarked
                  ? Expanded(
                      child: Icon(Icons.bookmark,
                          size: 13 * fontScale, color: theme.hintColor),
                    )
                  : SizedBox(), // Expanded(child: const SizedBox())
            ]);
      }));

  Widget buildRightContainer() => Expanded(
      flex: 12,
      child: Builder(
        builder: (context) => Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: ThreadTitle(title: thread.title),
                      ),
                      const Spacer(),
                      currentCatId == '1'
                          ? CategoryChip(
                              categoryName: thread.category.name,
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ThreadInfo(thread: thread)),
                Divider(height: 1, color: Theme.of(context).dividerColor)
              ],
            ),
      ));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Ink(
        color: theme.backgroundColor,
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ThreadPage(thread: thread)));
            },
            child: IntrinsicHeight(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildLeftContainer(),
                    buildRightContainer()
                  ]),
            )));
  }
}
