import 'package:flutter/material.dart';

TabBarTheme _darkTabBarTheme = const TabBarTheme(
  indicatorSize: TabBarIndicatorSize.tab,
  labelStyle: const TextStyle(fontSize: 16),
  unselectedLabelStyle: const TextStyle(fontSize: 16),
  labelColor: const Color.fromRGBO(255, 255, 255, 0.87),
  unselectedLabelColor: const Color.fromRGBO(255, 255, 255, 0.38),
);

Typography _darkTypography = Typography(
    black: Typography.blackCupertino,
    white: Typography.whiteCupertino,
    tall: Typography.tall2018,
    dense: Typography.dense2018,
    englishLike: Typography.englishLike2018);

TextTheme _darkTextTheme = Typography.whiteCupertino.apply(
    bodyColor: const Color.fromRGBO(255, 255, 255, 0.87),
    displayColor: const Color.fromRGBO(255, 255, 255, 0.87));

IconThemeData _iconTheme = IconThemeData(
  color: const Color.fromRGBO(255, 255, 255, 0.87),
);

AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 1.0,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: const Color(0xffffc107)));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(39, 39, 39, 1),
    primaryColorLight: const Color(0xff4f4f4f),
    primaryColorDark: const Color(0xff000000),
    accentColor: const Color(0xffffc107),
    accentColorBrightness: Brightness.dark,
    backgroundColor: const Color.fromRGBO(28, 28, 28, 1),
    bottomAppBarColor: const Color.fromRGBO(39, 39, 39, 1),
    canvasColor: const Color(0xff000000),
    cursorColor: const Color(0xffffc107),
    dividerColor: Colors.grey[800],
    disabledColor: const Color.fromRGBO(255, 255, 255, 0.38),
    highlightColor: Colors.grey[850],
    hintColor: const Color.fromRGBO(255, 255, 255, 0.6),
    textSelectionColor: const Color(0xffffc107),
    textSelectionHandleColor: const Color(0xffffc107),
    textTheme: _darkTextTheme,
    typography: _darkTypography,
    tabBarTheme: _darkTabBarTheme,
    iconTheme: _iconTheme,
    appBarTheme: _appBarTheme);
