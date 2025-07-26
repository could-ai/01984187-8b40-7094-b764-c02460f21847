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
        // 使用灰色作为主色调
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
        ),
        useMaterial3: true,
        // 设置全局背景色为浅灰色
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      darkTheme: ThemeData(
        // 暗色模式下使用灰色主色调
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        // 暗色模式背景也设置为深灰色
        scaffoldBackgroundColor: Colors.grey[850],
      ),
      // 统一使用暗色模式，以突出灰色背景效果
      themeMode: ThemeMode.dark,
      home: const PasswordListScreen(),
    );
  }
}
