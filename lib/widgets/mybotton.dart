import 'dart:math';

import 'package:black_broth/models/food_item_model.dart';
import 'package:black_broth/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/cart_service.dart';

class MyBotton extends StatelessWidget {
  final String text;
  const MyBotton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        height: 65,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
