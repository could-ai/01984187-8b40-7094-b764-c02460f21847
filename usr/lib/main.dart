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
        // 使用红色作为种子颜色
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // 暗色模式下使用红色主色调
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
        // 设置深色背景
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      // 使用暗色模式
      themeMode: ThemeMode.dark,
      home: const PasswordListScreen(),
    );
  }
}
