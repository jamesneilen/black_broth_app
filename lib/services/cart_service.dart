import 'package:flutter/material.dart';
import '../models/food_item_model.dart';

class CartItem {
  final food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(food) {
    int index = _cartItems.indexWhere((item) => item.food.name == food["name"]);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(food: food));
    }
    notifyListeners();
  }

  void removeFromCart(food) {
    _cartItems.removeWhere((item) => item.food.name == food["name"]);
    notifyListeners();
  }

  void increaseQuantity(food) {
    int index = _cartItems.indexWhere((item) => item.food.name == food['name']);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(food) {
    int index = _cartItems.indexWhere((item) => item.food.name == food['name']);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        removeFromCart(food); // Remove item if quantity is 1
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (item.food["price"] * item.quantity),
    );
  }
}
