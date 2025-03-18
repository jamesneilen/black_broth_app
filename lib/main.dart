import 'package:black_broth/theme/app_colors.dart';
import 'package:black_broth/views/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/cart_service.dart';
import 'services/favorite_service.dart';
import 'firebase_options.dart';
import 'services/food_service.dart';
import 'views/auths/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()..fetchFoodItems()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
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

      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/broth_logo.png'),
              backgroundColor: Colors.white,
              radius: 73 / 2,
            ),
          ),
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              "Food For\nEveryone",
              style: TextStyle(
                height: 0.9,
                fontSize: 55,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  bottom: 15,
                  child: Image.asset(
                    'assets/images/mantoy.png',
                    height: 298.54,
                    width: 225.4,
                  ),
                ),
                Positioned(
                  left: -70,
                  child: Image.asset(
                    'assets/images/womantoy.png',
                    height: 434.36,
                    width: 358.1,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withOpacity(0.5),
                          AppColors.primary,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
