import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: ListView(
        children: [
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //   child: Container(color: Colors.white.withOpacity(0.2)),
          // ),
          SizedBox(height: 80),
          ListTile(
            textColor: Colors.white,
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Offers and Promo'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.note),
            title: Text('Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Security'),
            onTap: () {},
          ),
          SizedBox(height: 350),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ListTile(
              title: Row(
                children: [
                  Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.exit_to_app, color: Colors.white),
                ],
              ),
              onTap: () {},
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
