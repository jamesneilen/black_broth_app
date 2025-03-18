import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodProvider with ChangeNotifier {
  String _selectedCategory = "Modern Food"; // Default category
  List<DocumentSnapshot> _foodItems = [];

  String get selectedCategory => _selectedCategory;
  List<DocumentSnapshot> get foodItems => _foodItems;

  // Update the selected category and fetch relevant food items
  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Fetch food items from Firestore
  void fetchFoodItems() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('food_items').get();
    _foodItems = snapshot.docs;
    notifyListeners();
  }
}
