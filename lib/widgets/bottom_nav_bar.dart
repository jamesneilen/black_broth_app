import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) => print(value),
      unselectedItemColor: AppColors.secondary,
      selectedItemColor: AppColors.primary,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'history'),
      ],
    );
  }
}
