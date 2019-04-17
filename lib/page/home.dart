import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/page/category.dart';
import 'package:lihkg_flutter/page/category_list.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';

class Home extends StatefulWidget {
  final List<CatList> catList;
  final SysPropsResponse sysPropsResponse;

  Home({this.catList, this.sysPropsResponse});

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentCatId = '1';
  List<CategoryBloc> _categoryBlocList = [];

  CatList getCategory() => widget.sysPropsResponse.categoryList
      .lastWhere((CatList catlist) => catlist.catId == currentCatId);

  List<Widget> _buildTabs() => getCategory()
      .subCategory
      .map((SubCategory subCategory) => Tab(text: subCategory.name))
      .toList();

  _createBloc() => getCategory().subCategory.forEach(
      (SubCategory subCategory) => _categoryBlocList.add(CategoryBloc(
          categoryRepository: CategoryRepository(subCategory: subCategory),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))));

  @override
  void initState() {
    _createBloc();
    super.initState();
  }

  @override
  void dispose() {
    for (final bloc in _categoryBlocList) {
      bloc.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        key: ValueKey(getCategory().subCategory.length),
        initialIndex: 0,
        length: getCategory().subCategory.length,
        child: Scaffold(
            appBar: AppBar(
              title: getCategory().subCategory.length > 1
                  ? TabBar(
                      tabs: _buildTabs(),
                      indicatorWeight: 3.0,
                      isScrollable: true)
                  : Text('${getCategory().subCategory[0].name}'),
              leading: Builder(
                builder: (context) {
                  final theme = Theme.of(context);
                  return IconButton(
                      icon: Icon(Icons.menu, color: theme.iconTheme.color),
                      onPressed: () => Scaffold.of(context).openDrawer());
                },
              ),
            ),
            drawer: Container(
              width: MediaQuery.of(context).size.width / 1.8,
              child: Drawer(
                child: CategoryListPage(
                  catId: currentCatId,
                  categoryList: widget.sysPropsResponse.fixedCategoryList,
                  changeCategoryCallback: (String catId) => setState(() {
                        currentCatId = catId;
                        if (_categoryBlocList.isNotEmpty)
                          _categoryBlocList.clear();
                        _createBloc();
                      }),
                ),
              ),
            ),
            body: TabBarView(
                key: ValueKey(currentCatId),
                children: _categoryBlocList
                    .map((CategoryBloc categoryBloc) =>
                        BlocProvider(bloc: categoryBloc, child: CategoryPage()))
                    .toList())));
  }
}
