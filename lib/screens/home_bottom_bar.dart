import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'categories_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import '../providers/cart_provider.dart';

class HomeBottomBar extends StatefulWidget {
  static const routeName = '/home-bottom-bar';

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  final List<Map<String, dynamic>> _screens = [
    {
      'title': 'Orders',
      'screen': OrdersScreen(),
    },
    {
      'title': 'Search',
      'screen': const Center(
        child: Text('Upcoming'),
      ),
    },
    {
      'title': 'Home',
      'screen': CategoriesScreen(),
    },
    {
      'title': 'Favorites',
      'screen': const Center(
        child: Text('Upcoming'),
      ),
    },
    {
      'title': 'Profile',
      'screen': const Center(
        child: Text('Upcoming'),
      ),
    },
  ];
  var _selectedIndex = 2;
  var _previousIndex = 0;

  void _selectScreen(int index) => setState(() {
    _previousIndex = _selectedIndex;
    _selectedIndex = index;
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(_screens[_selectedIndex]['title']),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              backgroundColor: Colors.transparent,
              // alignment: Alignment.bottomRight,
              offset: const Offset(-2, 4),
              label: Text(cart.productCount.toString()),
              child: ch,
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: _previousIndex > _selectedIndex ? FadeInLeft(
        duration: const Duration(milliseconds: 600),
        child: _screens[_selectedIndex]['screen'],
      ) : FadeInRight(
        duration: const Duration(milliseconds: 600),
        child: _screens[_selectedIndex]['screen'],
      ),
      bottomNavigationBar: CurvedNavigationBar(
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
    );
  }
}
