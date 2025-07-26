import 'package:flutter/material.dart';
import 'screens/password_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF0000), // Red color
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFE0E0), // Light red background
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF0000), // Red color
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF4A0000), // Dark red background
      ),
      themeMode: ThemeMode.system,
      home: const PasswordListScreen(),
    );
  }
}