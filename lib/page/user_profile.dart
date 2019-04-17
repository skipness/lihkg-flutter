import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/repository/repository.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/category/category_cell/thread_list_cell.dart';
import 'package:lihkg_flutter/widget/shimmer/shimmer.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({@required this.user});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  PreferenceBloc _preferenceBloc;
  List<UserProfileBloc> _userProfileBlocList;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _userProfileBlocList = [
      UserProfileBloc(
          userProfileRepository: UserProfileRepository(
              userId: widget.user.userId, sortBy: 'create_time'),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      UserProfileBloc(
          userProfileRepository: UserProfileRepository(
              userId: widget.user.userId, sortBy: 'reply_time'),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))
    ];
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  void dispose() {
    for (var bloc in _userProfileBlocList) {
      bloc.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildTabBarViews() =>
      _userProfileBlocList.map((UserProfileBloc bloc) {
        final _scrollController = ScrollController();
        return BlocBuilder(
            bloc: bloc,
            builder: (BuildContext context, UserProfileState state) {
              if (state is UserProfileUninitialized) return const ShimmerList();
              if (state is UserProfileError) return Container();
              if (state is UserProfileLoaded) {
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
                        loadMore: () => bloc.dispatch(FetchUserProfile()),
                        refresh: () {
                          bloc.dispatch(RefreshUserProfile());
                          return _refreshCompleter.future;
                        }));
              }
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
    final theme = Theme.of(context);
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.share, color: theme.iconTheme.color),
                      onPressed: () {
                        Share.share(
                            '${widget.user.nickname} #${widget.user.userId}\nhttps://lihkg.com/profile/${widget.user.userId}');
                      })
                ],
                title: Column(
                  children: <Widget>[
                    Expanded(
                        child: Text('${widget.user.nickname}',
                            style: theme.textTheme.subhead)),
                    Expanded(
                        child: Text('#${widget.user.userId}',
                            style: theme.textTheme.subhead
                                .copyWith(color: theme.hintColor)))
                  ],
                ),
                centerTitle:
                    theme.platform == TargetPlatform.iOS ? true : false,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TabBar(
                            tabs: [Tab(text: '主題新至舊'), Tab(text: '回覆新至舊')],
                            indicatorWeight: 3.0)
                      ]),
                )),
            body: BlocBuilder<PreferenceEvent, PreferenceState>(
                bloc: _preferenceBloc,
                builder: (BuildContext context, PreferenceState state) {
                  return PreferenceContext(
                      preference: (state is PreferenceLoaded
                          ? state.preferences[CAT_LIST_FONT_SIZE].value
                          : 1),
                      child: TabBarView(children: _buildTabBarViews()));
                })));
  }
}
