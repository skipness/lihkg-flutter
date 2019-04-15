import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';

typedef VoidCallback Authenticated();
typedef VoidCallback Unauthenticated();

class AuthListTile extends StatefulWidget {
  final Widget title;
  final Widget leading;
  final Authenticated authenticated;
  final Unauthenticated unauthenticated;

  AuthListTile({
    this.title,
    this.leading,
    this.authenticated,
    this.unauthenticated,
  });

  @override
  _AuthListTileState createState() => _AuthListTileState();
}

class _AuthListTileState extends State<AuthListTile> {
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  ListTile _buildListTile({bool enabled = true, VoidCallback onTap}) {
    return ListTile(
      enabled: enabled,
      leading: widget.leading,
      title: widget.title,
      onTap: () => onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
      bloc: _authenticationBloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationUninitialized ||
            state is AuthenticationLoading) {
          return _buildListTile(enabled: false);
        }

        if (state is AuthenticationUnauthenticated) {
          return _buildListTile(enabled: false, onTap: widget.unauthenticated);
        }

        if (state is AuthenticationAuthenticated) {
          return _buildListTile(enabled: false, onTap: widget.authenticated);
        }
      },
    );
  }
}
