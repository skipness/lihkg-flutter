import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/repository/repository.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/category/category_cell/thread_list_cell.dart';
import 'package:lihkg_flutter/widget/shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PreferenceBloc _preferenceBloc;
  List<SearchBloc> _searchBlocList;
  Completer<void> _refreshCompleter;
  String keyword = '';
  int currentIndex = 0;

  @override
  void initState() {
    _searchBlocList = [
      SearchBloc(
          searchRepository: SearchRepository(sortBy: 'score'),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      SearchBloc(
          searchRepository: SearchRepository(sortBy: 'desc_create_time'),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      SearchBloc(
          searchRepository: SearchRepository(sortBy: 'desc_reply_time'),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
    ];
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      // this method prevent tapping between taps will trigger rebuild twice.
      // Details: https://github.com/flutter/flutter/issues/13848
      if (!_tabController.indexIsChanging) {
        setState(() => currentIndex = _tabController.index);
      }
    });
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  void dispose() {
    for (var bloc in _searchBlocList) {
      bloc.dispose();
    }
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _buildTabBarViews() => _searchBlocList.map((SearchBloc bloc) {
        return Builder(builder: (BuildContext context) {
          final _scrollController = PrimaryScrollController.of(context);
          final theme = Theme.of(context);
          return BlocBuilder(
              bloc: bloc,
              builder: (BuildContext context, SearchState state) {
                if (state is SearchEmpty)
                  return Container(color: theme.backgroundColor);
                if (state is SearchError) return Container();
                if (state is Searching) return const ShimmerList();
                if (state is SearchSuccess) {
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
                          loadMore: () => bloc.dispatch(Search(text: keyword)),
                          refresh: () {
                            bloc.dispatch(ResetSearch(text: keyword));
                            return _refreshCompleter.future;
                          }));
                }
              });
        });
      }).toList();

  Widget listCell(dynamic item) {
    final thread = item as Item;
    return ThreadListCell(
        key: ValueKey(thread.threadId), thread: thread, currentCatId: '1');
  }

  Widget listFooter(bool hasReachedEnd) {
    final theme = Theme.of(context);
    return hasReachedEnd
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
                child: Text('完',
                    style: theme.textTheme.title
                        .copyWith(color: theme.accentColor))),
          )
        : const ShimmerCell();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<SearchEvent, SearchState>(
              bloc: _searchBlocList[currentIndex],
              builder: (BuildContext context, SearchState state) {
                return LiTextField(
                  hintText: '搜尋標題或編號、會員名稱或編號',
                  textInputAction: TextInputAction.search,
                  onTextChanged: (text) {},
                  onTextSubmitted: (text) {
                    if (text.trim().isEmpty) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('關鍵字不能為空白')));
                    } else {
                      setState(() => keyword = text);
                      for (final bloc in _searchBlocList) {
                        if (state is SearchSuccess || state is SearchError)
                          bloc.dispatch(ResetSearch(text: text));
                        if (state is SearchEmpty)
                          bloc.dispatch(Search(text: text));
                      }
                    }
                    // onTextEditingComplete: () {},
                  },
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(35),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(text: '最相關'),
                          Tab(text: '主題新至舊'),
                          Tab(text: '回覆新至舊')
                        ],
                        indicatorWeight: 3.0)
                  ]),
            )),
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<PreferenceEvent, PreferenceState>(
            bloc: _preferenceBloc,
            builder: (BuildContext context, PreferenceState state) {
              return PreferenceContext(
                  preference: (state is PreferenceLoaded
                      ? state.preferences[CAT_LIST_FONT_SIZE].value
                      : 1),
                  child: TabBarView(
                      controller: _tabController,
                      children: _buildTabBarViews()));
            }));
  }
}
