import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:la_geopuh/assets/themes.dart';

import '../../assets/colors.dart';
import '../widgets/item_card.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: accent_2),
            );
          } else {
            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('profiles')
                    .doc(userId)
                    .collection('basket')
                    .snapshots(),
                builder: (context, basketSnapshot) {
                  if (!basketSnapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(color: accent_2),
                    );
                  } else {
                    var favs = basketSnapshot.data!.docs;
                    var items = snapshot.data!.docs;

                    var result = items
                        .where((item) =>
                            favs.any((fav) => fav["item_id"] == item.id))
                        .toList();

                    return result.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (1 / 1.5),
                              crossAxisCount: 2,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemCount: result.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                snapshot.data == null
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: accent_2,
                                      ))
                                    : itemCard(context, result[index]),
                          )
                        : Center(
                            child: Text(
                              "Корзина пуста :(",
                              style: transparentLabelStyle,
                            ),
                          );
                  }
                });
          }
        });
  }
}
