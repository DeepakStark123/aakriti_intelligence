import 'package:aakriti_inteligence/screens/home_screen.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: AppColors.kbackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.kbackgroundColor,
          foregroundColor: AppColors.kblackColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kbuttonColor,
            foregroundColor: AppColors.kwhiteColor,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
