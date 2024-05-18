import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/assets/themes.dart';
import 'package:la_geopuh/data/firebase_firestore/profile_collection.dart';
import 'package:la_geopuh/views/widgets/icon_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final collectionReference = FirebaseFirestore.instance.collection("profiles");

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId = FirebaseAuth.instance.currentUser!.uid.toString();
  dynamic docs;

  Future<int> countFavsForUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userId)
          .collection('favs')
          .get();

      return querySnapshot.size;
    } catch (e) {
      return 0;
    }
  }

  int counter = 0;

  ProfileCollection profileCollection = ProfileCollection();

  getUserById() async {
    final DocumentSnapshot documentSnapshot =
        await collectionReference.doc(userId).get();
    counter = await countFavsForUser(userId);
    setState(() {
      docs = documentSnapshot;
    });
  }

  @override
  void initState() {
    getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return docs == null
        ? const Center(
            child: CircularProgressIndicator(
              color: accent_2,
            ),
          )
        : Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: foreground,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/profile_editing",
                            arguments: docs);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: docs["image"] == ""
                                ? const Icon(
                                    Icons.account_circle_rounded,
                                    color: regular,
                                    size: 50,
                                  )
                                : Image(
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(docs["image"])),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              "\t\t${docs["surname"]} ${docs["name"].toString()[0]}.",
                              style: labelStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: iconBox(
                                context,
                                Icons.favorite_outline_rounded,
                                "Избранное",
                                "Товаров: $counter",
                                0.3)),
                        GestureDetector(
                            onTap: () {},
                            child: iconBox(context, Icons.card_travel_rounded,
                                "Покупки", "Заказать снова", 0.3)),
                        GestureDetector(
                            onTap: () {},
                            child: iconBox(context, Icons.star_border_rounded,
                                "Ждут отзыва", "...", 0.3)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: foreground,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("О приложении", style: labelStyle),
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: regular,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: regular.withOpacity(0.3),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Разработчики", style: labelStyle),
                            const Icon(
                              Icons.arrow_right_rounded,
                              color: regular,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: regular.withOpacity(0.3),
                      ),
                    ],
                  )),
            ],
          );
  }
}
