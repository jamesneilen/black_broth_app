import 'package:black_broth/theme/app_colors.dart';
import 'package:black_broth/widgets/food_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food_item_model.dart';
import '../../services/food_service.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/search_bar.dart';
import '../cart/cart_screen.dart';
import 'side_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
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
          MySearchBar(
            controller: _searchController,
            onChanged: (query) => categoryProvider.searchFood(query),
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
                      itemCount: categoryProvider.cfilteredFoodItems.length,
                      itemBuilder: (context, index) {
                        final food = categoryProvider.cfilteredFoodItems[index];
                        return FoodCard(food: food);
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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
