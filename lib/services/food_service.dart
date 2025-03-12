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
        category: "Modern Food",
        description:
            "A hamburger is a sandwich consisting of one or more cooked patties of ground meat, usually beef, placed inside a sliced bread roll or bun.",
      ),
      FoodItem(
        name: "Jollof Rice",
        image: "assets/images/modern_food/jellof_rice.jpg",
        price: 12.50,
        category: "Modern Food",
        description:
            "Jollof rice is a one-pot rice dish popular in many West African countries. It is a rich and flavorful dish made with rice, tomatoes, and a mix of spices.",
      ),
      FoodItem(
        name: "Grilled Fish",
        image: "assets/images/modern_food/grilled_fish.jpg",
        price: 14.99,
        category: "Modern Food",
        description:
            "Grilled fish is a healthy and delicious dish that is easy to prepare. It is a great source of protein and omega-3 fatty acids.",
      ),
    ],
    "African Food": [
      FoodItem(
        name: "Cassava and Plum",
        image: "assets/images/african_food/cassava_plum.jpg",
        price: 8.99,
        category: "African Food",
        description:
            "Cassava and plum is a traditional African dish made with cassava, plum, and a mix of spices. It is a delicious and nutritious meal that is easy to prepare.",
      ),
      FoodItem(
        name: "Ekwang",
        image: "assets/images/african_food/ekwang.jpg",
        price: 10.99,
        category: "African Food",
        description:
            "Ekwang is a traditional Cameroonian dish made with grated cocoyam, palm oil, and a mix of spices. It is a delicious and hearty meal that is perfect for special occasions.",
      ),
      FoodItem(
        name: "Okro Soup",
        image: "assets/images/african_food/okro_soup.jpg",
        price: 11.50,
        category: "African Food",
        description:
            "Okro soup is a popular West African dish made with okra, meat, and a mix of spices. It is a delicious and nutritious meal that is easy to prepare.",
      ),
    ],
    "Drinks": [
      FoodItem(
        name: "Palm Wine",
        image: "assets/images/drinks/palm_wine.jpg",
        price: 3.99,
        category: "Drinks",
        description:
            "Palm wine is a popular African alcoholic beverage made from the sap of various species of palm trees. It is a sweet and refreshing drink that is enjoyed by many people in Africa.",
      ),
      FoodItem(
        name: "top",
        image: "assets/images/drinks/top.jpg",
        price: 4.50,
        category: "Drinks",
        description:
            "Top is a popular Cameroonian drink which is refreshing and naturally sweet.",
      ),

      FoodItem(
        name: "Folere",
        image: "assets/images/drinks/folere.jpg",
        price: 2.99,
        category: "Drinks",
        description:
            "Folere is a traditional Cameroonian drink made from . It is a sweet and tangy drink that is enjoyed by many people in Cameroon and it is made from so many ingredients including hibiscus and pineapple peels. Folere is also known as zobo in Nigeria, bissap in Senegal and sorrell in the Caribbean",
      ),
    ],
  };
  List<FoodItem> _filteredFoodItems = [];
  bool isSearching = false;

  List<FoodItem> get allFoodItems =>
      _foodItems.values.expand((items) => items).toList();
  List<FoodItem> get filteredFoodItems =>
      _filteredFoodItems.isEmpty
          ? _foodItems.values.expand((items) => items).toList()
          : _filteredFoodItems;

  // Function to filter food items based on search query
  void searchFood(String query) {
    if (query.isEmpty) {
      _filteredFoodItems = [];
      isSearching = false;
    } else {
      _filteredFoodItems =
          _foodItems.values
              .expand((items) => items)
              .toList()
              .where(
                (food) =>
                    food.name.toLowerCase().contains(query.toLowerCase()) ||
                    food.category!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    food.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
              )
              .toList();
      isSearching = true;
    }
    notifyListeners();
  }

  void clearSearch() {
    isSearching = false;
    _filteredFoodItems = [];
    notifyListeners();
  }

  int get selectedCategoryIndex => _selectedCategoryIndex;
  List<String> get categories => _categories;
  List<FoodItem> get cfilteredFoodItems =>
      _foodItems[_categories[_selectedCategoryIndex]] ?? [];

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }
}
