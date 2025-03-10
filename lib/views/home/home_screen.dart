import 'package:black_broth/theme/app_colors.dart';
import 'package:black_broth/widgets/food_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food_item_model.dart';
import '../../services/food_service.dart';
import 'side_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ['Modern Food', 'Africa Food', 'Drinks'];
  int _currentIndex = 0;
  int selectedCategoryIndex = 0;

  void onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Container(
              height: 20,
              width: 20,
              child: Image.asset('assets/icons/cart.png', color: Colors.black),
            ),
            onPressed: () {},
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Delicious\n Food For You",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aclonica',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: SearchBar(
              backgroundColor: WidgetStatePropertyAll(AppColors.tertiary),
              elevation: WidgetStatePropertyAll(0),
              focusNode: FocusNode(),
              leading: Icon(Icons.search, color: AppColors.secondary),
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(categoryProvider.categories.length, (
                  index,
                ) {
                  bool isSelected =
                      categoryProvider.selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => categoryProvider.selectCategory(index),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            categoryProvider.categories[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? AppColors.primary
                                      : AppColors.secondary,
                            ),
                          ),
                          SizedBox(height: 4),
                          if (isSelected)
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 3,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 40),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 60),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 260,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.filteredFoodItems.length,
                      itemBuilder: (context, index) {
                        final food = categoryProvider.filteredFoodItems[index];
                        return FoodCard(
                          name: food.name,
                          image: food.image,
                          price: food.price,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: SideBar(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => print(value),
        unselectedItemColor: AppColors.secondary,
        selectedItemColor: AppColors.primary,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'history'),
        ],
      ),
    );
  }
}
