import 'package:black_broth/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/food_service.dart';
import 'views/auths/signin_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
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
