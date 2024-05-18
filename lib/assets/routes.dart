import 'package:flutter/material.dart';
import 'package:la_geopuh/views/landing.dart';
import 'package:la_geopuh/views/pages/auth_page.dart';
import 'package:la_geopuh/views/pages/basket_page.dart';
import 'package:la_geopuh/views/pages/favorite_page.dart';
import 'package:la_geopuh/views/pages/home_page.dart';
import 'package:la_geopuh/views/pages/item_page.dart';
import 'package:la_geopuh/views/pages/profile_editing_page.dart';
import 'package:la_geopuh/views/pages/profile_page.dart';
import 'package:la_geopuh/views/pages/regist_page.dart';

final routes = {
  "/": (context) => const Landing(),
  "/home": (context) => const HomePage(),
  "/auth": (context) => const AuthPage(),
  "/reg": (context) => const RegistPage(),
  "/fav": (context) => const FavoritePage(),
  "/basket": (context) => const BasketPage(),
  "/profile": (context) => const ProfilePage(),
  "/item": (context) =>
      ItemPage(docs: ModalRoute.of(context)?.settings.arguments),
  "/profile_editing": (context) =>
      ProfileEditor(docs: ModalRoute.of(context)?.settings.arguments),
};
