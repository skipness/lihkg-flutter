import 'package:flutter/material.dart';

TabBarTheme _lightTabBarTheme = const TabBarTheme(
  indicatorSize: TabBarIndicatorSize.tab,
  labelStyle: const TextStyle(fontSize: 16),
  unselectedLabelStyle: const TextStyle(fontSize: 16),
  labelColor: const Color.fromRGBO(0, 0, 0, 0.87),
  unselectedLabelColor: const Color.fromRGBO(0, 0, 0, 0.38),
);

Typography _lightTypography = Typography(
    black: Typography.blackCupertino,
    white: Typography.whiteCupertino,
    tall: Typography.tall2018,
    dense: Typography.dense2018,
    englishLike: Typography.englishLike2018);

TextTheme _lightTextTheme = Typography.whiteCupertino.apply(
    bodyColor: const Color.fromRGBO(0, 0, 0, 0.87),
    displayColor: const Color.fromRGBO(0, 0, 0, 0.87));

IconThemeData _iconTheme = IconThemeData(
  color: const Color.fromRGBO(0, 0, 0, 0.6),
);

AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 1.0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: const Color(0xffffc107)));

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xfffafafa),
  primaryColorLight: const Color(0xffffffff),
  primaryColorDark: const Color(0xffc7c7c7),
  accentColor: const Color(0xffffc107),
  accentColorBrightness: Brightness.light,
  backgroundColor: const Color(0xfffafafa),
  bottomAppBarColor: Colors.white,
  canvasColor: const Color(0xff737373),
  cursorColor: const Color(0xffffc107),
  dividerColor: const Color.fromRGBO(0, 0, 0, 0.12),
  disabledColor: const Color.fromRGBO(0, 0, 0, 0.38),
  highlightColor: const Color(0xffffc107),
  hintColor: const Color.fromRGBO(0, 0, 0, 0.6),
  textSelectionColor: const Color(0xffffc107),
  textSelectionHandleColor: const Color(0xffffc107),
  appBarTheme: _appBarTheme,
  textTheme: _lightTextTheme,
  typography: _lightTypography,
  tabBarTheme: _lightTabBarTheme,
  iconTheme: _iconTheme,
);
