import 'package:flutter/material.dart';

class FavoriteItem {
  final String id;
  final String name;
  final String image;
  final double price;

  FavoriteItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });
}

class FavoritesProvider with ChangeNotifier { 
  final Map<String, FavoriteItem> _favorites = {};

  Map<String, FavoriteItem> get favorites => _favorites;

  // Add or remove item from favorites
  void toggleFavorite(String id, String name, String image, double price) {
    if (_favorites.containsKey(id)) {
      _favorites.remove(id);
    } else {
      _favorites[id] = FavoriteItem(id: id, name: name, image: image, price: price);
    }
    notifyListeners();
  }

  // Check if item is in favorites
  bool isFavorite(String id) {
    return _favorites.containsKey(id);
  }
}
