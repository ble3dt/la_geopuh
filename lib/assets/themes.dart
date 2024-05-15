import 'package:flutter/material.dart';
import 'package:la_geopuh/assets/colors.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: foreground,
      titleTextStyle: headerStyle,
    ),
    scaffoldBackgroundColor: background,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: foreground,
      selectedItemColor: regular,
      unselectedItemColor: regular.withOpacity(0.6),
      selectedLabelStyle: labelStyle,
      unselectedLabelStyle: labelStyle,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ));

TextStyle labelStyle = const TextStyle(
    fontFamily: 'Open Sans', fontSize: 16, fontWeight: FontWeight.w500, color: regular);

TextStyle buttonTextStyle = const TextStyle(
    fontFamily: 'Open Sans', fontSize: 16, fontWeight: FontWeight.w500, color: foreground);

TextStyle transparentLabelStyle = TextStyle(
    fontFamily: 'Open Sans', fontSize: 16, fontWeight: FontWeight.w500, color: regular.withOpacity(0.6));

TextStyle headerStyle = const TextStyle(
    fontFamily: 'Open Sans', fontSize: 30, fontWeight: FontWeight.w600);

ButtonStyle accentButton = const ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(regular),
);
