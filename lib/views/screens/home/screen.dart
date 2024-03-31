import 'package:flutter/material.dart';

import 'pages/favorites_page.dart';
import 'pages/search_page.dart';

class HomeScreen extends StatefulWidget {
  static String path = "/home";
  static String name = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          SearchPage(),
          FavoritesPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (page) {
          _pageController.jumpToPage(page);
          _currentPage = page;
          setState(() {});
        },
        selectedIndex: _currentPage,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.search, color: Colors.grey),
            selectedIcon: Icon(Icons.search, color: theme.primaryColor),
            label: "검색",
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border, color: Colors.grey),
            selectedIcon: Icon(Icons.favorite, color: theme.primaryColor),
            label: "즐겨찾기",
          ),
        ],
      ),
    );
  }
}
