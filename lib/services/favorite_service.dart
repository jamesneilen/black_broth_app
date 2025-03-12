import 'package:flutter/material.dart';

import '../models/food_item_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<FoodItem> _favoriteItems = [];

  List<FoodItem> get favoriteItems => _favoriteItems;

  void toggleFavorite(FoodItem food) {
    if (_favoriteItems.contains(food)) {
      _favoriteItems.remove(food);
    } else {
      _favoriteItems.add(food);
    }
    notifyListeners();
  }

  bool isFavorite(FoodItem food) {
    return _favoriteItems.contains(food);
  }
}
