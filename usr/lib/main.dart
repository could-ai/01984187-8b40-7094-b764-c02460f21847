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
        // 使用蓝色作为主色调，带来清新、专业的视觉感受
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
        // 设置全局背景色为蓝色，使应用整体风格统一
        scaffoldBackgroundColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        // 暗色模式下依然保持蓝色主色调
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        // 暗色模式背景也设置为蓝色，延续应用主题
        scaffoldBackgroundColor: Colors.blue,
      ),
      // 统一使用暗色模式，以突出蓝色背景效果
      themeMode: ThemeMode.dark,
      home: const PasswordListScreen(),
    );
  }
}
