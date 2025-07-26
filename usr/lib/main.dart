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
          seedColor: Colors.red, // Changed to red
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.red, // Red background
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red, // Red color
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.red, // Red background
      ),
      themeMode: ThemeMode.dark, // Force dark theme
      home: const PasswordListScreen(),
    );
  }
}
