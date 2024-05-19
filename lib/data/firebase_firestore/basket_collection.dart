import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasketCollection {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addToBasket(String itemId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("basket")
          .doc(itemId)
          .set({
        'item_id': itemId,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> removeFromBasket(String itemId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid.toString();
      await _firebaseFirestore
          .collection("profiles")
          .doc(userId)
          .collection("basket")
          .doc(itemId)
          .delete();
    } catch (e) {
      return;
    }
  }
}