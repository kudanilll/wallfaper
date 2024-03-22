import 'package:flutter/material.dart';
import 'package:wallfaper/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        toolbarHeight: 72,
        actions: [
          GestureDetector(
            onTap: () {
              // Navigasi ke halaman profil
              Navigator.pushNamed(context, Routes.profile);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://365webresources.com/wp-content/uploads/2016/09/FREE-PROFILE-AVATARS.png'),
                  radius: 18,
                ),
              ),
            ),
          )
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
