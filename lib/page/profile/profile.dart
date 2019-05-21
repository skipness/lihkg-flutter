import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/repository/repository.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart'
    show InAppBrowser;
import 'package:lihkg_flutter/widget/profile/email_text.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _profileBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _profileBloc = ProfileBloc(
      authenticationBloc: _authenticationBloc,
      profileRepository: ProfileRepository(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('帳號'),
      ),
      body: Ink(
        color: theme.backgroundColor,
        child: BlocBuilder<ProfileEvent, ProfileState>(
          bloc: _profileBloc,
          builder: (BuildContext context, ProfileState state) {
            if (state is ProfileLoaded) {
              final createDate = DateTime.fromMillisecondsSinceEpoch(
                  state.profile.response.me.createTime * 1000);
              return ListView(
                controller: PrimaryScrollController.of(context),
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${state.profile.response.me.nickname}',
                    ),
                    subtitle: Text(
                      '#${state.profile.response.me.userId}',
                      style: theme.textTheme.subtitle
                          .copyWith(color: theme.hintColor),
                    ),
                    trailing: EmailText(
                      email: state.profile.response.me.email,
                    ),
                  ),
                  ListTile(
                    title: Text('註冊日期'),
                    trailing: Text(
                      '${createDate.year}-${createDate.month}-${createDate.day}',
                      style: theme.textTheme.subhead
                          .copyWith(color: theme.hintColor),
                    ),
                  ),
                  ListTile(
                    title: Text('上線日數'),
                    trailing: Text(
                      '${DateTime.now().difference(createDate).inDays}日',
                      style: theme.textTheme.subhead
                          .copyWith(color: theme.hintColor),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('追蹤名單'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.hintColor,
                    ),
                  ),
                  ListTile(
                    title: Text('封鎖名單'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.hintColor,
                    ),
                  ),
                  ListTile(
                    title: Text('關鍵字過濾'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.hintColor,
                    ),
                  ),
                  ListTile(
                    title: Text('更改帳號資料'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: theme.hintColor,
                    ),
                    onTap: () {
                      InAppBrowser(context: context)
                          .open(url: 'https://lihkg.com/me/profile/edit');
                    },
                  ),
                  ListTile(
                      title: Text('更改密碼'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: theme.hintColor,
                      ),
                      onTap: () {
                        InAppBrowser(context: context)
                            .open(url: 'https://lihkg.com/me/password/edit');
                      }),
                  Divider(),
                  ListTile(
                    title: Center(
                      child: Text(
                        '登出',
                        style: theme.textTheme.subhead
                            .copyWith(color: theme.errorColor),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ));
          },
        ),
      ),
    );
  }
}
