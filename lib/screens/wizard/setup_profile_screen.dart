import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallfaper/routes.dart';
import 'package:wallfaper/services/auth_service.dart';
import 'package:wallfaper/services/storage_service.dart';
import 'package:wallfaper/utils/image_picker.dart';
import 'package:wallfaper/widgets/header.dart';
import 'package:wallfaper/widgets/profile_image.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});
  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  Future<void> pickImage() async {
    File? inputImage = await pickImageFromGallery();
    StorageService().uploadProfilePhoto(inputImage!);
    AuthService()
        .getProfileURLFromFirestore()
        .then((result) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Header(
              title: 'Profile Images',
              subtitle: 'Post your profile image now.',
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 56,
                bottom: 24,
              ),
              child: InkWell(
                child: ProfileImage(
                  size: 136,
                  renderEditIcon: false,
                  onPressed: () => pickImage(),
                  imageUrl:
                      'https://cdn.idntimes.com/content-images/community/2023/01/whatsapp-image-2023-01-08-at-115243-am-770cbc2889bb4c14bf5042be7b505d5d-7d2e9e7f5bf393938ad6f394176ffded.jpeg',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  // 'Hello, ${AuthService().getUsernameFromFirestore().toString()}',
                  'Hello, Marsha',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, Routes.home),
          child: const Text(
            'NEXT',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
