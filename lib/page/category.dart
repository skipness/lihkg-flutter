import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/category/category_cell.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/shimmer/shimmer.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  State createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  PreferenceBloc _preferenceBloc;
  CategoryBloc _categoryBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  Widget listCell(dynamic item) {
    final thread = item as Item;
    return ThreadListCell(
        key: ValueKey(thread.threadId),
        thread: thread,
        currentCatId: _categoryBloc.subCategory.catId);
  }

  Widget listFooter(bool hasReachedEnd) {
    final theme = Theme.of(context);
    return hasReachedEnd
        ? Center(
            child: Text('完',
                style:
                    theme.textTheme.title.copyWith(color: theme.accentColor)))
        : const ShimmerCell();
  }

  @override
  Widget build(BuildContext context) {
    final _scrollController = PrimaryScrollController.of(context);
    return BlocBuilder<PreferenceEvent, PreferenceState>(
        bloc: _preferenceBloc,
        builder: (BuildContext context, PreferenceState state) {
          return PreferenceContext(
              preference: (state is PreferenceLoaded
                  ? state.preferences[CAT_LIST_FONT_SIZE].value
                  : 1),
              child: BlocBuilder<CategoryEvent, CategoryState>(
                  bloc: _categoryBloc,
                  builder: (BuildContext context, CategoryState state) {
                    if (state is CategoryUninitialized)
                      return const ShimmerList();
                    if (state is CategoryError) return Container();
                    if (state is CategoryLoaded) {
                      _refreshCompleter?.complete();
                      _refreshCompleter = Completer();
                      return PersistenceTabview(
                          child: LiListView(
                              items: state.items,
                              cell: listCell,
                              footer: listFooter,
                              scrollController: _scrollController,
                              showScrollBar: true,
                              hasReachedEnd: state.hasReachedEnd,
                              loadMore: () =>
                                  _categoryBloc.dispatch(FetchCategory()),
                              refresh: () {
                                _categoryBloc.dispatch(RefreshCategory());
                                return _refreshCompleter.future;
                              }));
                    }
                  }));
        });
  }
}
