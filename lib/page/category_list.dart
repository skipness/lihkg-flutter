import 'package:flutter/material.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/page/login.dart';
import 'package:lihkg_flutter/page/search.dart';
import 'package:lihkg_flutter/page/setting.dart';

typedef void ChangeCategoryCallback(String catId);

class CategoryListPage extends StatefulWidget {
  final String catId;
  final categoryList;
  final ChangeCategoryCallback changeCategoryCallback;

  CategoryListPage(
      {@required this.catId,
      @required this.categoryList,
      @required this.changeCategoryCallback});

  @override
  State createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget buildGridView(List<FixedCategoryList> categoryList, int index) {
    final theme = Theme.of(context);
    return GridView.builder(
      key: PageStorageKey('CATEGORY_LIST'),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (100 / 45),
      ),
      itemCount: categoryList[index].catList.length,
      itemBuilder: (BuildContext context, int i) {
        return FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget
                  .changeCategoryCallback(categoryList[index].catList[i].catId);
            },
            child: Text('${categoryList[index].catList[i].name}',
                textAlign: TextAlign.center,
                style: theme.textTheme.subhead.copyWith(
                    color: widget.catId == categoryList[index].catList[i].catId
                        ? theme.accentColor
                        : theme.hintColor)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: Ink(
            color: theme.backgroundColor,
            child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // ListTile(
                    //     leading: Icon(Icons.person_outline,
                    //         color: theme.iconTheme.color),
                    //     title: Text('帳號', style: theme.textTheme.subhead),
                    //     onTap: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //           fullscreenDialog: true,
                    //           builder: (BuildContext context) => LoginPage()));
                    //     }),
                    ListTile(
                        leading:
                            Icon(Icons.search, color: theme.iconTheme.color),
                        title: Text('搜尋', style: theme.textTheme.subhead),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => SearchPage()));
                        }),
                    // ListTile(
                    //   leading:
                    //       Icon(Icons.history, color: theme.iconTheme.color),
                    //   title: Text('回帶', style: theme.textTheme.subhead),
                    //   onTap: () {},
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.favorite_border,
                    //       color: theme.iconTheme.color),
                    //   title: Text('飛佛', style: theme.textTheme.subhead),
                    //   onTap: () {},
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.inbox, color: theme.iconTheme.color),
                    //   title: Text('發送匣', style: theme.textTheme.subhead),
                    //   onTap: () {},
                    // ),
                    ListTile(
                        leading: Icon(Icons.settings_applications,
                            color: theme.iconTheme.color),
                        title: Text('設定', style: theme.textTheme.subhead),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Setting()));
                        }),
                    Divider(
                      color: theme.dividerColor,
                      height: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        key: PageStorageKey('CATEGORY_LIST'),
                        itemCount: widget.categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              index == 0
                                  ? const SizedBox()
                                  : Text(
                                      '${widget.categoryList[index].name}',
                                      textAlign: TextAlign.start,
                                      style: theme.textTheme.subhead,
                                    ),
                              buildGridView(widget.categoryList, index)
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ))));
  }
}
