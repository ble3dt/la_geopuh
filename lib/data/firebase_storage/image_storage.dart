import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageStorage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String? imagePathURL;

  Future addImageStorage(XFile path) async {
    try {
      final pathImage = 'users/${path.name}';
      Reference storageReference = _firebaseStorage.ref().child(pathImage);
      UploadTask uploadTask = storageReference.putFile(File(path.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      imagePathURL = await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      return;
    }
  }
}