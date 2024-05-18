import 'package:flutter/material.dart';

import '../../assets/colors.dart';
import '../../assets/themes.dart';

Widget iconBox(context, IconData icon, String name, String moreInfo, double size) => Container(
      width: MediaQuery.of(context).size.width * size,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: accent_1, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: regular.withOpacity(0.5)),
          Text(
            name,
            style: labelStyle,
          ),
          Text(
            moreInfo,
            style: transparentLabelStyle_12,
          ),
        ],
      ),
    );
