import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  late Map<String, CartItemModel> _items = {
    '0': CartItemModel(id: '0', title: 'test', quantity: 2, price: 15.55),
    '1': CartItemModel(id: '1', title: 'test2', quantity: 4, price: 5.99),
  };

  Map<String, CartItemModel> get items {
    return {..._items};
  }

  int get productCount {
    return _items.length;
  }

  double get totalPrice {
    var price = 0.0;
    _items.forEach((key, cartItem) {
      price += cartItem.price * cartItem.quantity;
    });
    return price;
  }

  void addToCart(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingCartItem) => CartItemModel(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingItem) => CartItemModel(
          id: existingItem.id,
          title: existingItem.title,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
