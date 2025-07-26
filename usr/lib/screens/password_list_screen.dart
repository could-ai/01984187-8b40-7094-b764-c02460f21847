import 'package:flutter/material.dart';
import '../models/password.dart';
import 'password_detail_screen.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  // Sample data for categories
  final List<Category> _categories = [
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

  void _navigateAndAddPassword(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordDetailScreen(categories: _categories)),
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
      MaterialPageRoute(builder: (context) => PasswordDetailScreen(password: password, categories: _categories)),
    );

    if (result != null && result is Password) {
      setState(() {
        _passwords[index] = result;
      });
    }
  }

  void _deletePassword(Password passwordToDelete) {
    setState(() {
      _passwords.removeWhere((password) => password.id == passwordToDelete.id);
    });
  }

  // Group passwords by category
  Map<String, List<Password>> _groupPasswordsByCategory() {
    final Map<String, List<Password>> grouped = {};
    for (var password in _passwords) {
      if (!grouped.containsKey(password.categoryName)) {
        grouped[password.categoryName] = [];
      }
      grouped[password.categoryName]!.add(password);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedPasswords = _groupPasswordsByCategory();
    final categoryNames = groupedPasswords.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Manager'),
      ),
      body: _passwords.isEmpty
          ? const Center(
              child: Text(
                'No passwords saved yet.\nTap the + button to add one!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: categoryNames.length,
              itemBuilder: (context, index) {
                final categoryName = categoryNames[index];
                final passwordsInCategory = groupedPasswords[categoryName]!;
                return ExpansionTile(
                  title: Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  initiallyExpanded: true, // Keep categories expanded by default
                  children: passwordsInCategory.map((password) {
                    return ListTile(
                      leading: const Icon(Icons.vpn_key),
                      title: Text(password.website),
                      subtitle: Text(password.username),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deletePassword(password),
                      ),
                      onTap: () {
                        // Find the original index to pass for editing
                        final originalIndex = _passwords.indexWhere((p) => p.id == password.id);
                        if(originalIndex != -1) {
                           _navigateAndEditPassword(context, password, originalIndex);
                        }
                      },
                    );
                  }).toList(),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndAddPassword(context),
        tooltip: 'Add Password',
        child: const Icon(Icons.add),
      ),
    );
  }
}
