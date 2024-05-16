import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/assets/themes.dart';

Widget itemCard(context, dynamic docs) => Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: foreground,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10), bottom: Radius.zero),
                child: Image(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.cover,
                  image: NetworkImage(docs['image']),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docs["name"],
                      style: labelStyle,
                    ),
                    Row(
                      children: [
                        Text(
                          "${(double.parse(docs["cost"]) - (double.parse(docs["cost"]) * double.parse(docs["discount"])) / 100).floor()} Р.\t",
                          style: costStyle,
                        ),
                        Text(
                          "${docs["cost"]} Р.",
                          style: strikeStyle,
                        ),
                        Text(
                          "\t-${docs["discount"]}%",
                          style: costStyle,
                        ),
                      ],
                    ),
                    Text(
                      docs["description"],
                      style: transparentLabelStyle,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
