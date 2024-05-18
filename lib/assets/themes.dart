import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  fontFamily: 'Open Sans',
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: regular,
  overflow: TextOverflow.ellipsis,
);

TextStyle costStyle = const TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: accent_3,
  overflow: TextOverflow.ellipsis,
);

TextStyle strikeStyle = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: regular.withOpacity(0.6),
  decoration: TextDecoration.lineThrough,
  decorationColor: regular.withOpacity(0.6),
  decorationThickness: 5.0,
  overflow: TextOverflow.ellipsis,
);

TextStyle buttonTextStyle = const TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: foreground,
  overflow: TextOverflow.ellipsis,
);

TextStyle transparentLabelStyle = TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: regular.withOpacity(0.6),
  overflow: TextOverflow.ellipsis,
);

TextStyle headerStyle = const TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: regular,
  overflow: TextOverflow.ellipsis,
);

TextStyle accentHeaderStyle = const TextStyle(
  fontFamily: 'Open Sans',
  fontSize: 30,
  fontWeight: FontWeight.w600,
  color: accent_3,
  overflow: TextOverflow.ellipsis,
);

ButtonStyle accentButton = const ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(regular),
);

ButtonStyle accentButton_2 = const ButtonStyle(
  padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
  backgroundColor: WidgetStatePropertyAll(accent_2),
);
