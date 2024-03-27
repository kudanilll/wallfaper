import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  }
  return null;
}

Future<File?> pickImageFromCamera() async {
  final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.camera);
  if (image != null) {
    return File(image.path);
  }
  return null;
}
