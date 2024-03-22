import 'package:flutter/material.dart';
import 'dart:io';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageUrl,
    // required this.onPressed,
  });

  final String imageUrl;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(Theme.of(context).colorScheme.inversePrimary),
          Positioned(
            right: 4,
            top: 10,
            child: buildEditIcon(Theme.of(context).colorScheme.inversePrimary),
          )
        ],
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imageUrl.contains('https://')
        ? NetworkImage(imageUrl)
        : FileImage(File(imageUrl));
    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
