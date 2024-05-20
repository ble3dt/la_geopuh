import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/assets/themes.dart';

Widget basketItem(context, dynamic docs) => Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/item", arguments: docs);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: foreground,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    fit: BoxFit.cover,
                    image: NetworkImage(docs['image']),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
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
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
