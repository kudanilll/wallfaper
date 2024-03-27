import 'package:flutter/material.dart';
import 'dart:io';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool renderEditIcon;
  final VoidCallback? onPressed;
  final VoidCallback? onEditIconPressed;

  const ProfileImage({
    super.key,
    required this.imageUrl,
    this.size = 70,
    this.renderEditIcon = true,
    this.onPressed,
    this.onEditIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(Theme.of(context).colorScheme.inversePrimary),
          if (renderEditIcon)
            Positioned(
              right: 4,
              top: 10,
              child:
                  buildEditIcon(Theme.of(context).colorScheme.inversePrimary),
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
      radius: size + 4,
      backgroundColor: color,
      child: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          backgroundImage: image as ImageProvider,
          radius: size,
        ),
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
        all: 8,
        child: IconButton(
          icon: const Icon(Icons.edit),
          color: color,
          iconSize: 20,
          onPressed: onEditIconPressed,
        ),
      );

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
        ),
      );
}
