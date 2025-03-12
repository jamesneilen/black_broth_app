import 'package:black_broth/views/food/food_item_view_screen.dart';
import 'package:black_broth/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/cart_service.dart';
import 'services/favorite_service.dart';
import 'services/food_service.dart';
import 'views/auths/signin_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange));
    return MaterialApp(
      title: 'black broth',
      debugShowCheckedModeBanner: false,

      home: HomeScreen(),
    );
  }
}
