import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_geopuh/assets/colors.dart';
import 'package:la_geopuh/views/widgets/item_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: accent_2),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / 1.5),
                crossAxisCount: 2,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => snapshot.data == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: accent_2,
                    ))
                  : itemCard(context, snapshot.data!.docs[index]),
            );
          }
        });
  }
}
