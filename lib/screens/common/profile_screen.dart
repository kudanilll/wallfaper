import 'package:enefty_icons/enefty_icons.dart';
import 'package:wallfaper/models/user.dart';
import 'package:wallfaper/routes.dart';
import 'package:wallfaper/services/auth_service.dart';
import 'package:wallfaper/widgets/button.dart';
import 'package:wallfaper/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _user = User(
    name: 'Daniel',
    email: 'daniel@gmail.com',
    image:
        'https://365webresources.com/wp-content/uploads/2016/09/FREE-PROFILE-AVATARS.png',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 72,
            title: Text(
              'Hello, ${_user.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
          ),
          InkWell(
            child: ProfileImage(
              imageUrl: _user.image,
            ),
          ),
          buildUserInfo(
            'Name',
            _user.name,
          ),
          buildUserInfo(
            'Email',
            _user.email,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: SizedBox(
              width: double.infinity,
              child: Button(
                onTap: () {
                  AuthService().signOut();
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                text: 'LOG OUT',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildUserInfo(String item, String value) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                const Icon(
                  EneftyIcons.edit_outline,
                  color: Colors.grey,
                )
              ],
            )
          ],
        ),
      );

  FutureOr onUpdate(dynamic value) {
    setState(() {});
  }
}
