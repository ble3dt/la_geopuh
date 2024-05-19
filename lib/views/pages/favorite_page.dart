import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:la_geopuh/assets/themes.dart';
import '../../assets/colors.dart';
import '../widgets/item_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: regular,
          ),
        ),
        title: Text(
          "Избранное",
          style: headerStyle,
        ),
        centerTitle: true,
      ),
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
                      .collection('favs')
                      .snapshots(),
                  builder: (context, favSnapshot) {
                    if (!favSnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: accent_2),
                      );
                    } else {
                      var favs = favSnapshot.data!.docs;
                      var items = snapshot.data!.docs;

                      var result = items.where((item) => favs.any((fav) => fav["item_id"] == item.id)).toList();

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (1 / 1.5),
                          crossAxisCount: 2,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: result.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => snapshot.data == null
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: accent_2,
                              ))
                            : itemCard(context, result[index]),
                      );
                    }
                  });
            }
          }),
    );
  }
}
