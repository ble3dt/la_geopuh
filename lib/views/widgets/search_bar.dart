import 'package:flutter/material.dart';

import '../../assets/colors.dart';
import '../../assets/themes.dart';

AppBar searchBar = AppBar(
  title: GestureDetector(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: accent_1, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: regular,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              "Искать на La Geopuh",
              style: labelStyle,
            ),
          )
        ],
      ),
    ),
    onTap: () {},
  ),
);