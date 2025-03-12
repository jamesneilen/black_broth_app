import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  const MySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: SearchBar(
        onChanged: onChanged,
        controller: controller,
        backgroundColor: WidgetStatePropertyAll(AppColors.tertiary),
        elevation: WidgetStatePropertyAll(0),
        focusNode: FocusNode(),
        leading: Icon(Icons.search, color: AppColors.secondary),
      ),
    );
  }
}
