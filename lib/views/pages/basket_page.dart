import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:la_geopuh/assets/themes.dart';
import 'package:la_geopuh/views/widgets/basket_item.dart';

import '../../assets/colors.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid.toString();
    int fullCost = 0;

    return Scaffold(
      body: StreamBuilder(
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

                      fullCost = result.fold<int>(
                          0,
                          (previousValue, element) =>
                              previousValue + int.parse(element["cost"]));

                      return result.isNotEmpty
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (1 / 0.4),
                                crossAxisCount: 1,
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
                                      : basketItem(context, result[index]),
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
          }),
      bottomNavigationBar: Container(
        color: foreground,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              fullCost.toString(),
              style: labelStyle,
            ),
            ElevatedButton(
              onPressed: () {},
              style: accentButton_2,
              child: Text("Оплатить", style: headerStyle),
            ),
          ],
        ),
      ),
    );
  }
}
