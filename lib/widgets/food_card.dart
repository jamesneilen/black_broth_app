import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;

  const FoodCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 3,
            child: Container(
              width: 180,
              padding: EdgeInsets.only(
                top: 50,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "\XAF${price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -25, // Moves image slightly out of the card
            left: 35, // Centers the image
            child: CircleAvatar(
              radius: 60, // Increases size for visibility
              backgroundColor: Colors.white, // Optional: Makes it pop
              backgroundImage: AssetImage(image),
            ),
          ),
        ],
      ),
    );
  }
}
