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
        // 使用蓝色作为种子颜色
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        // 直接设置背景色为浅蓝色
        scaffoldBackgroundColor: Colors.blue.shade100,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        // 暗色模式下使用蓝色主色调
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // 统一使用浅色模式，以突出浅蓝色背景效果
      themeMode: ThemeMode.light,
      home: const PasswordListScreen(),
    );
  }
}
