import 'package:enefty_icons/enefty_icons.dart';
import 'package:wallfaper/models/user_info.dart';
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
  final _user = UserInfo(
    name: 'Marsha',
    email: 'test@gmail.com',
    image:
        'https://cdn.idntimes.com/content-images/community/2023/01/whatsapp-image-2023-01-08-at-115243-am-770cbc2889bb4c14bf5042be7b505d5d-7d2e9e7f5bf393938ad6f394176ffded.jpeg',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
      body: Column(
        children: [
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
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure to log out?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          AuthService().signOut();
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
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
