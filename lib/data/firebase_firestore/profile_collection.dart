import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCollection {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addProfile(
      String id,
      String surname,
      String name,
      String phone,
      String email,
      String password,
      String image) async {
    try {
      await _firebaseFirestore.collection("profiles").doc(id).set({
        'uid': id,
        'surname': surname,
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'image': image,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> editProfile(dynamic docs, String surname, String name,
      String patronymic, String phone) async {
    try {
      await _firebaseFirestore.collection("profiles").doc(docs.id).update({
        'surname': surname,
        'name': name,
        'phone': phone,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> editProfileImage(dynamic docs, String image) async {
    try {
      await _firebaseFirestore.collection('profiles').doc(docs.id).update({
        'image': image,
      });
    } catch (e) {
      return;
    }
  }

  Future<void> deleteProfile(dynamic docs) async {
    try {
      await _firebaseFirestore.collection("profiles").doc(docs.id).delete();
    } catch (e) {
      return;
    }
  }
}