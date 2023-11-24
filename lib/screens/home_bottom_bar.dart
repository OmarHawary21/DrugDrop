import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animate_do/animate_do.dart';

import 'categories_screen.dart';

class HomeBottomBar extends StatefulWidget {
  static const routeName = '/home-bottom-bar';

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final List<Map<String, dynamic>> _screens = [
    {
      'title': 'Home',
      'screen': Center(
        child: Text('Upcoming'),
      ),
    },
    {
      'title': 'Home',
      'screen': Center(
        child: Text('Upcoming'),
      ),
    },
    {
      'title': 'Home',
      'screen': CategoriesScreen(),
    },
    {
      'title': 'Home',
      'screen': Center(
        child: Text('Upcoming'),
      ),
    },
    {
      'title': 'Home',
      'screen': Center(
        child: Text('Upcoming'),
      ),
    },
  ];
  var _selectedIndex = 2;
  var _previousIndex = 0;

  void _selectScreen(int index) => setState(() {
    _previousIndex = _selectedIndex;
    _selectedIndex = index;
    print('Previous $_previousIndex');
    print('Current $_selectedIndex');
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
      body: _previousIndex > _selectedIndex ? FadeInLeft(
        duration: Duration(milliseconds: 600),
        child: _screens[_selectedIndex]['screen'],
      ) : FadeInRight(
        duration: Duration(milliseconds: 600),
        child: _screens[_selectedIndex]['screen'],
      ),
      bottomNavigationBar: Container(
        child: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height * 0.08,
          color: colorScheme.primary,
          backgroundColor: Colors.transparent,
          onTap: _selectScreen,
          index: _selectedIndex,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 500),
          items: const [
            Icon(
              Icons.local_shipping,
              color: Colors.white,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
