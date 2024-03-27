import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:wallfaper/constants/global_variables.dart';
import 'package:wallfaper/routes.dart';
// import 'package:wallfaper/services/api_service.dart';
// import 'package:wallfaper/services/auth_service.dart';
import 'package:wallfaper/utils/time_greeting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isLoading = false;

  Future<void> _onRefresh(BuildContext context) async {
    refreshKey.currentState?.show(atTop: false);
    // final model = await ApiService().getWallpaper();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
    return;
  }

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
                'https://cdn.idntimes.com/content-images/community/2023/01/whatsapp-image-2023-01-08-at-115243-am-770cbc2889bb4c14bf5042be7b505d5d-7d2e9e7f5bf393938ad6f394176ffded.jpeg',
              ),
              radius: 18,
            ),
          ),
          title: Text(
            TimeGreeting().getTimeGreeting(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Transform.translate(
            offset: const Offset(0, -2),
            child: Text(
              'Marsha',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          horizontalTitleGap: 12,
          contentPadding: const EdgeInsets.only(left: 2),
        ),
        toolbarHeight: 72,
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(
              EneftyIcons.search_normal_2_outline,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.notification),
              icon: const Icon(
                EneftyIcons.notification_outline,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: RefreshIndicator(
                key: refreshKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 18),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                            'assets/images/test_image_wallpaper.jpeg'),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Discover',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Text(
                          'Find the best wallpaper',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    for (int i = 0; i < 10; i++)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                              'assets/images/test_image_wallpaper.jpeg'),
                        ),
                      ),
                  ],
                ),
                onRefresh: () => _onRefresh(context),
              ),
            ),
    );
  }
}
