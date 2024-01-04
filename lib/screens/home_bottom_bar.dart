import 'dart:convert';

import '/main.dart';
import '/providers/notification_provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '/screens/favorites_screen.dart';
import '/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '/screens/notifications_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'categories_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'search-screen.dart';
//import 'favorites_screen.dart';
import '../providers/cart_provider.dart';

class HomeBottomBar extends StatefulWidget {
  static const routeName = '/home-bottom-bar';
  int userId;

  HomeBottomBar(this.userId);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  String socketId = '';
  String channel_name = '';
  var channel;
  String privateChannelName = '';
  String authBroadCast = '';
  @override
  void initState() {
    channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.43.239:6001/app/1029384756'));
    // TODO: implement initState
    channel.sink.add(jsonEncode({
      "event": "pusher:subscribe",
      "data": {"channel": "notifications", "auth": ""}
    }));
    channel_name = 'private-notifications';
    channel.stream.listen((message) {
      Map getData = jsonDecode(message);
      if (getData['event'] == 'pusher:connection_established') {
        socketId = jsonDecode(getData['data'])['socket_id'];
        Provider.of<NotificationProvider>(context, listen: false).broadcastAuth(
            socketId,
            channel_name,
            '1|RcIInMNgjhllOGmcNyuDBEepf5LoSieeLsI7gDtha05d41a6',
            channel);
      }
      if(getData['event'] == '')
      print(getData);
    });

    super.initState();
  }

  final List<Map<String, dynamic>> _screens = [
    {
      'title': LocaleKeys.orders.tr(),
      'screen': OrdersScreen(),
    },
    {
      'title': LocaleKeys.search.tr(),
      'screen': SearchScreen(),
    },
    {
      'title': LocaleKeys.home.tr(),
      'screen': CategoriesScreen(),
    },
    {
      'title': LocaleKeys.favorites.tr(),
      'screen': FavoritesScreen(),
    },
    {
      'title': 
      
      Keys.profile.tr(),
      'screen': ProfileScreen(),
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
      extendBody: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(_screens[_selectedIndex]['title']),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(NotificationsScreen.routeName);
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              backgroundColor: colorScheme.background,
              // alignment: Alignment.bottomRight,
              offset: const Offset(-10, 12),
              label: Text(cart.items.length.toString()),
              child: ch,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 5),
              child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: _previousIndex > _selectedIndex
          ? FadeInLeft(
              duration: const Duration(milliseconds: 600),
              child: _screens[_selectedIndex]['screen'],
            )
          : FadeInRight(
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
