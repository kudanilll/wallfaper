import 'package:enefty_icons/enefty_icons.dart';
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
        title: ListTile(
          leading: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.profile),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://365webresources.com/wp-content/uploads/2016/09/FREE-PROFILE-AVATARS.png'),
              radius: 18,
            ),
          ),
          title: Text(
            'Good Afternoon',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          subtitle: Text(
            'Daniel',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          horizontalTitleGap: 12,
          contentPadding: const EdgeInsets.only(left: 2),
        ),
        toolbarHeight: 72,
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              EneftyIcons.search_normal_2_outline,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: null,
              icon: Icon(
                EneftyIcons.notification_outline,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
