import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lihkg_flutter/bloc/bloc.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/widget/login/login_text_form_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  LoginBloc _loginBloc;
  AuthenticationBloc _authenticationBloc;
  String _email;
  String _password;
  bool _hidePassword = true;
  bool _autoValidate = false;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
        userRepository: _authenticationBloc.userRepository,
        authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              children: <Widget>[
                Image.asset('assets/logo.webp', height: 130),
                const SizedBox(height: 30),
                LiTextFormField(
                  focusNode: _emailFocusNode,
                  textEditingController: _emailController,
                  hintText: 'ISP／大學／大專院校電郵',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon:
                      Icon(Icons.alternate_email, color: theme.hintColor),
                  textInputAction: TextInputAction.next,
                  onSaved: (String value) => setState(() => _email = value),
                  onFormSubmitted: (_) {
                    _emailFocusNode.unfocus();
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  validator: (value) {
                    if (!_loginBloc.isEmailValidate(value)) {
                      return '電郵無效';
                    }
                  },
                ),
                const SizedBox(height: 10),
                LiTextFormField(
                  focusNode: _passwordFocusNode,
                  textEditingController: _passwordController,
                  hintText: '密碼',
                  obscureText: _hidePassword,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icon(Icons.lock_outline, color: theme.hintColor),
                  textInputAction: TextInputAction.done,
                  onSaved: (String value) => setState(() => _password = value),
                  validator: (value) {
                    if (!_loginBloc.isPasswordValidate(value)) {
                      return '密碼無效';
                    }
                  },
                ),
                const SizedBox(height: 10),
                state is LoginLoading
                    ? const Center(
                        child: const CircularProgressIndicator(strokeWidth: 2))
                    : RaisedButton(
                        child: Text('登入'),
                        color: theme.accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _loginBloc.dispatch(LoginButtonPressed(
                                email: _email, password: _password));
                          } else {
                            setState(() => _autoValidate = true);
                          }
                        },
                      ),
                const SizedBox(height: 10),
                Container(
                    child: Center(
                        child: state is LoginFailure
                            ? Text('${state.error}',
                                style: theme.textTheme.subtitle
                                    .copyWith(color: theme.errorColor))
                            : null)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                          child: Text('註冊',
                              style: TextStyle(color: theme.hintColor)),
                          onPressed: () {
                            InAppBrowser browser =
                                InAppBrowser(context: context);
                            browser.open(
                                url: 'https://lihkg.com/register?step=1');
                          }),
                      Text('|', style: TextStyle(color: theme.hintColor)),
                      FlatButton(
                          child: Text('忘記密碼',
                              style: TextStyle(color: theme.hintColor)),
                          onPressed: () {
                            InAppBrowser browser =
                                InAppBrowser(context: context);
                            browser.open(
                                url: 'https://lihkg.com/forget-password');
                          })
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
