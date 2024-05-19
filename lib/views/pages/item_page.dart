import 'package:flutter/material.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/assets/themes.dart';
import 'package:la_geopuh/data/firebase_firestore/basket_collection.dart';
import 'package:la_geopuh/data/firebase_firestore/favorite_collection.dart';
import 'package:la_geopuh/views/widgets/search_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemPage extends StatefulWidget {
  final dynamic docs;

  const ItemPage({super.key, @required this.docs});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  FavoriteCollection favoriteCollection = FavoriteCollection();
  BasketCollection basketCollection = BasketCollection();

  bool isFav = false;
  bool? isInBasket;

  String userId = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<void> checkIfItemIsFavorite() async {
    try {
      final favsSnapshot = await FirebaseFirestore.instance
          .collection("profiles")
          .doc(userId)
          .collection("favs")
          .doc(widget.docs.id)
          .get();

      setState(() {
        isFav = favsSnapshot.exists;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> checkIfItemIsInBasket() async {
    try {
      final favsSnapshot = await FirebaseFirestore.instance
          .collection("profiles")
          .doc(userId)
          .collection("basket")
          .doc(widget.docs.id)
          .get();

      setState(() {
        isInBasket = favsSnapshot.exists;
      });
    } catch (e) {
      return;
    }
  }

  Widget? bottomWidget() {
    if (isInBasket == true) {
      return ElevatedButton(
          onPressed: () {
            basketCollection.removeFromBasket(widget.docs.id);
            checkIfItemIsInBasket();
          },
          style: accentButton_3,
          child: Text(
            "Убрать",
            style: headerStyle,
          ));
    } else if (isInBasket == false) {
      return ElevatedButton(
        onPressed: () {
          basketCollection.addToBasket(widget.docs.id);
          checkIfItemIsInBasket();
        },
        style: accentButton_2,
        child: Text(
          "В корзину",
          style: headerStyle,
        ),
      );
    } else {
      return null;
    }
  }

  @override
  void initState() {
    checkIfItemIsFavorite();
    checkIfItemIsInBasket();
    super.initState();
  }

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

    IconButton addToFav = isFav
        ? IconButton(
            onPressed: () {
              favoriteCollection.removeFromFav(widget.docs.id);
              checkIfItemIsFavorite();
            },
            icon: const Icon(
              Icons.favorite_rounded,
              color: accent_3,
            ))
        : IconButton(
            onPressed: () {
              favoriteCollection.addToFav(widget.docs.id);
              checkIfItemIsFavorite();
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              widget.docs["name"],
                              style: headerStyle,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Divider(
                            color: regular.withOpacity(0.3),
                          ),
                          Row(
                            children: [
                              Text(
                                "${(double.parse(widget.docs["cost"]) - (double.parse(widget.docs["cost"]) * double.parse(widget.docs["discount"])) / 100).floor()} Р.\t",
                                style: headerStyle,
                              ),
                              Text("-${widget.docs["discount"]}%",
                                  style: accentHeaderStyle),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: regular.withOpacity(0.3),
                      ),
                      Text(
                        "${widget.docs["description"]}",
                        style: transparentLabelStyle,
                        overflow: TextOverflow.visible,
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
            child: bottomWidget()));
  }
}
