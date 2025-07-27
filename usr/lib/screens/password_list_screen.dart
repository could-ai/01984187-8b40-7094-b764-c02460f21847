import 'package:flutter/material.dart';
import '../models/password.dart';
import '../screens/news_screen.dart';
import 'password_detail_screen.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  // Add 'Favorites' category
  final List<Category> _categories = [
    Category(id: '0', name: 'Favorites'),
    Category(id: '1', name: 'Work'),
    Category(id: '2', name: 'Social'),
    Category(id: '3', name: 'Entertainment'),
  ];

  // Updated placeholder list with categories and favorites
  final List<Password> _passwords = [
    Password(id: '1', website: 'Google', username: 'user@gmail.com', password: 'password123', categoryId: '1', categoryName: 'Work', isFavorite: true),
    Password(id: '2', website: 'Facebook', username: 'user@facebook.com', password: 'password456', categoryId: '2', categoryName: 'Social'),
    Password(id: '3', website: 'Netflix', username: 'user@netflix.com', password: 'password789', categoryId: '3', categoryName: 'Entertainment', isFavorite: true),
    Password(id: '4', website: 'LinkedIn', username: 'user@linkedin.com', password: 'password101', categoryId: '1', categoryName: 'Work'),
  ];

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

  void _deletePassword(Password passwordToDelete) {
    setState(() {
      _passwords.removeWhere((p) => p.id == passwordToDelete.id);
    });
  }

  void _navigateToNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewsScreen()),
    );
  }

  Widget _buildCategoryPasswords(Category category) {
    // Filter for favorites or by category
    final passwordsToShow = category.id == '0'
        ? _passwords.where((p) => p.isFavorite).toList()
        : _passwords.where((p) => p.categoryId == category.id).toList();

    if (passwordsToShow.isEmpty) {
      return Center(
        child: Text(
          'No passwords in this category.',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
        ),
      );
    }

    return ListView.builder(
      itemCount: passwordsToShow.length,
      itemBuilder: (context, index) {
        final password = passwordsToShow[index];
        final originalIndex = _passwords.indexWhere((p) => p.id == password.id);

        return ListTile(
          leading: const Icon(Icons.vpn_key),
          title: Text(password.website),
          subtitle: Text(password.username),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (password.isFavorite)
                const Icon(Icons.star, color: Colors.amber),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deletePassword(password),
              ),
            ],
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
              tooltip: 'Vietnam News',
              onPressed: () => _navigateToNews(context),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: _categories.map((c) => Tab(text: c.name)).toList(),
          ),
        ),
        body: TabBarView(
          children: _categories.map((c) => _buildCategoryPasswords(c)).toList(),
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
