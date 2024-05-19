import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteCollection {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addToFav(String itemId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("favs")
          .doc(itemId)
          .set({
        'item_id': itemId,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> removeFromFav(String itemId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("favs")
          .doc(itemId)
          .delete();
    } catch (e) {
      return;
    }
  }
}
