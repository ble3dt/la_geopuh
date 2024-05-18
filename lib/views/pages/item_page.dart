import 'package:flutter/material.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/assets/themes.dart';
import 'package:la_geopuh/views/widgets/search_bar.dart';

class ItemPage extends StatefulWidget {
  final dynamic docs;

  const ItemPage({super.key, @required this.docs});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    IconButton goBack = IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: regular,
        ));

    IconButton addToFav = IconButton(
        onPressed: () {
          // TODO: Сделать добавление в избранное и изменение иконки
        },
        icon: const Icon(
          Icons.favorite_outline_rounded,
          color: regular,
        ));

    return Scaffold(
      appBar: searchBar(goBack, [addToFav]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: foreground,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50))),
              child: Column(
                children: [
                  Image(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.width * 1,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.docs['image']),
                  ),
                  const SizedBox(height: 50)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: foreground, borderRadius: BorderRadius.circular(50)),
              width: MediaQuery.of(context).size.width * 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.docs["name"], style: headerStyle),
                        Row(
                          children: [
                            Text(
                                "${(double.parse(widget.docs["cost"]) - (double.parse(widget.docs["cost"]) * double.parse(widget.docs["discount"])) / 100).floor()} Р.\t",
                                style: headerStyle),
                            Text("-${widget.docs["discount"]}%",
                                style: accentHeaderStyle),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${widget.docs["description"]}",
                      style: transparentLabelStyle,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: foreground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {},
          style: accentButton_2,
          child: Text(
            "В корзину",
            style: headerStyle,
          ),
        ),
      ),
    );
  }
}
