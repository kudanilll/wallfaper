import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:wallfaper/services/auth_service.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePhoto(File imageFile) async {
    final storageRef =
        _storage.ref().child('profile-images/${AuthService().getUserId()}.jpg');
    final uploadTask = storageRef.putFile(
      imageFile,
      SettableMetadata(
        contentType: 'image/jpeg',
      ),
    );
    await uploadTask.whenComplete(() {});
    final photoUrl = await storageRef.getDownloadURL();

    // Perbarui URL gambar di Firestore
    await AuthService().updateProfileURLInFirestore(photoUrl);

    return photoUrl;
  }
}
