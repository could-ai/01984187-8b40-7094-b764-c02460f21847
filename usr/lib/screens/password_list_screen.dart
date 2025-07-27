import 'package:flutter/material.dart';
import '../models/password.dart';
import 'settings_screen.dart'; // Import the new settings screen
import 'password_detail_screen.dart';
import 'news_screen.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  // Sample data for categories
  List<Category> _categories = [
    Category(id: '1', name: 'Work'),
    Category(id: '2', name: 'Social'),
    Category(id: '3', name: 'Entertainment'),
  ];

  // Updated placeholder list with categories
  final List<Password> _passwords = [
    Password(id: '1', website: 'Google', username: 'user@gmail.com', password: 'password123', categoryId: '1', categoryName: 'Work'),
    Password(id: '2', website: 'Facebook', username: 'user@facebook.com', password: 'password456', categoryId: '2', categoryName: 'Social'),
    Password(id: '3', website: 'Netflix', username: 'user@netflix.com', password: 'password789', categoryId: '3', categoryName: 'Entertainment'),
    Password(id: '4', website: 'LinkedIn', username: 'user@linkedin.com', password: 'password101', categoryId: '1', categoryName: 'Work'),
  ];

  // Navigate to add password page
  void _navigateAndAddPassword(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordDetailScreen(categories: _categories),
      ),
    );

    if (result != null && result is Password) {
      setState(() {
        _passwords.add(result);
      });
    }
  }

  // Navigate to edit password page
  void _navigateAndEditPassword(BuildContext context, Password password, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordDetailScreen(password: password, categories: _categories),
      ),
    );

    if (result != null && result is Password) {
      setState(() {
        _passwords[index] = result;
      });
    }
  }

  // Delete password
  void _deletePassword(Password passwordToDelete) {
    setState(() {
      _passwords.removeWhere((p) => p.id == passwordToDelete.id);
    });
  }

  // Navigate to news screen
  void _navigateToNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewsScreen()),
    );
  }

  // Navigate to settings screen
  void _navigateToSettings(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(categories: _categories),
      ),
    );

    if (result != null && result is List<Category>) {
      setState(() {
        _categories = result;
      });
    }
  }

  // Build password list for a specific category
  Widget _buildCategoryPasswords(Category category) {
    final passwordsInCategory = _passwords
        .where((p) => p.categoryId == category.id)
        .toList();

    if (passwordsInCategory.isEmpty) {
      return const Center(
        child: Text(
          'No passwords in this category.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: passwordsInCategory.length,
      itemBuilder: (context, index) {
        final password = passwordsInCategory[index];
        // Find original index for editing
        final originalIndex = _passwords.indexWhere((p) => p.id == password.id);
        return ListTile(
          leading: const Icon(Icons.vpn_key),
          title: Text(password.website),
          subtitle: Text(password.username),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deletePassword(password),
          ),
          onTap: () {
            if (originalIndex != -1) {
              _navigateAndEditPassword(context, password, originalIndex);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Password Manager'),
          actions: [
            IconButton(
              icon: const Icon(Icons.article_outlined),
              tooltip: 'China News',
              onPressed: () => _navigateToNews(context),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () => _navigateToSettings(context),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _categories.map((c) => Tab(text: c.name)).toList(),
          ),
        ),
        body: TabBarView(
          children: _categories
              .map((c) => _buildCategoryPasswords(c))
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateAndAddPassword(context),
          tooltip: 'Add Password',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
