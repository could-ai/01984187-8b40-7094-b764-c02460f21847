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
        // 使用绿色作为主色调，带来自然、平和的视觉感受
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
        // 设置全局背景色为绿色，使应用整体风格统一
        scaffoldBackgroundColor: Colors.green,
      ),
      darkTheme: ThemeData(
        // 暗色模式下依然保持绿色主色调
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        // 暗色模式背景也设置为绿色，延续应用主题
        scaffoldBackgroundColor: Colors.green,
      ),
      // 统一使用暗色模式，以突出绿色背景效果
      themeMode: ThemeMode.dark,
      home: const PasswordListScreen(),
    );
  }
}
