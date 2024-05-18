import 'package:flutter/material.dart';
import 'package:la_geopuh/views/pages/basket_page.dart';
import 'package:la_geopuh/views/pages/main_page.dart';
import 'package:la_geopuh/views/pages/profile_page.dart';
import 'package:la_geopuh/views/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final pageList = const [
    MainPage(),
    BasketPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar(null, null),
      body: pageList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label: "Главная", icon: Icon(Icons.home_rounded)),
          BottomNavigationBarItem(
              label: "Корзина", icon: Icon(Icons.shopping_basket_rounded)),
          BottomNavigationBarItem(
              label: "Профиль", icon: Icon(Icons.person_rounded)),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
