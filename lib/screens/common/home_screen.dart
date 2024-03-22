import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:wallfaper/routes.dart';

StaggeredGridTile item_1 = const StaggeredGridTile.count(
    crossAxisCellCount: 2,
    mainAxisCellCount: 2,
    child: Card(color: Color.fromARGB(120, 4, 138, 64)));

StaggeredGridTile item_2 = const StaggeredGridTile.count(
    crossAxisCellCount: 2,
    mainAxisCellCount: 3,
    child: Card(color: Color.fromARGB(50, 4, 138, 64)));

List<StaggeredGridTile> _cardTile = <StaggeredGridTile>[
  item_1,
  item_2,
  item_1,
  item_2,
  item_1,
  item_2,
  item_1,
  item_1,
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
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
            fontSize: 28,
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
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://365webresources.com/wp-content/uploads/2016/09/FREE-PROFILE-AVATARS.png'),
                  radius: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: SingleChildScrollView(
          controller: _controller,
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: _cardTile,
          ),
        ),
      ),
    );
  }
}
