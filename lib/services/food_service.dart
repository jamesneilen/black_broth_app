import 'package:flutter/material.dart';

import '../models/food_item_model.dart';

class CategoryProvider with ChangeNotifier {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ["Modern Food", "African Food", "Drinks"];

  final Map<String, List<FoodItem>> _foodItems = {
    "Modern Food": [
      FoodItem(
        name: "Hamburger",
        image: "assets/images/modern_food/hamburger.jpg",
        price: 9.99,
      ),
      FoodItem(
        name: "Jollof Rice",
        image: "assets/images/modern_food/jellof_rice.jpg",
        price: 12.50,
      ),
      FoodItem(
        name: "Grilled Fish",
        image: "assets/images/modern_food/grilled_fish.jpg",
        price: 14.99,
      ),
    ],
    "African Food": [
      FoodItem(
        name: "Cassava and Plum",
        image: "assets/images/african_food/cassava_plum.jpg",
        price: 8.99,
      ),
      FoodItem(
        name: "Ekwang",
        image: "assets/images/african_food/ekwang.jpg",
        price: 10.99,
      ),
      FoodItem(
        name: "Okro Soup",
        image: "assets/images/african_food/okro_soup.jpg",
        price: 11.50,
      ),
    ],
    "Drinks": [
      FoodItem(
        name: "Palm Wine",
        image: "assets/images/drinks/palm_wine.jpg",
        price: 3.99,
      ),
      FoodItem(name: "top", image: "assets/images/drinks/top.jpg", price: 4.50),
      FoodItem(
        name: "Folere",
        image: "assets/images/drinks/folere.jpg",
        price: 2.99,
      ),
    ],
  };

  int get selectedCategoryIndex => _selectedCategoryIndex;
  List<String> get categories => _categories;
  List<FoodItem> get filteredFoodItems =>
      _foodItems[_categories[_selectedCategoryIndex]] ?? [];

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }
}
