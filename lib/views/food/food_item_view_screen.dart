import 'package:black_broth/models/food_item_model.dart';
import 'package:black_broth/theme/app_colors.dart';
import 'package:black_broth/widgets/mybotton.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/cart_service.dart';

class FoodItemViewScreen extends StatelessWidget {
  final FoodItem food;
  const FoodItemViewScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.favorite_outline), onPressed: () {}),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(food.image),
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          DotsIndicator(
            position: 0,
            dotsCount: 5,
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: AppColors.primary,
            ),
          ),
          SizedBox(height: 23),
          Text(
            food.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(height: 10),
          Text(
            '\XAF${food.price}',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Text(food.description, style: TextStyle(fontSize: 15)),
            ),
          ),
          SizedBox(height: 150),
          GestureDetector(
            onTap: () {
              print('Add to cart');
              Provider.of<CartProvider>(context, listen: false).addToCart(food);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${food.name} added to cart!")),
              );
            },
            child: MyBotton(text: 'Add To Cart'),
          ),
        ],
      ),
    );
  }
}
