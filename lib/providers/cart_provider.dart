import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  late final List<CartItemModel> _items = [
    CartItemModel(
        id: '0', productId: 3, title: 'omar', quantity: 2, price: 1600),
    CartItemModel(
        id: '1', productId: 3, title: 'test2', quantity: 4, price: 2400),
  ];

  List<CartItemModel> get items {
    return [..._items];
  }

  void addToCart(int id, String title, int price, int quantity) {
    _items.add(CartItemModel(
      id: 'id',
      productId: id,
      title: title,
      quantity: quantity,
      price: price,
    ));
  }

  void removeSingleItem(String id) {}

  void removeItem(int id) {}

  void clearCart() {}
}
