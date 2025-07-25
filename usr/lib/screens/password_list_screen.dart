import 'package:flutter/material.dart';
import '../models/password.dart';
import 'password_detail_screen.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  _PasswordListScreenState createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  // This is a placeholder list. In a real app, you would fetch this from a database.
  final List<Password> _passwords = [
    Password(id: '1', website: 'Google', username: 'user@gmail.com', password: 'password123'),
    Password(id: '2', website: 'Facebook', username: 'user@facebook.com', password: 'password456'),
  ];

  void _navigateAndAddPassword(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PasswordDetailScreen()),
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
      MaterialPageRoute(builder: (context) => PasswordDetailScreen(password: password)),
    );

    if (result != null && result is Password) {
      setState(() {
        _passwords[index] = result;
      });
    }
  }

  void _deletePassword(int index) {
    // NOTE: This is where you would delete the password from the database.
    setState(() {
      _passwords.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: _passwords.length,
              itemBuilder: (context, index) {
                final password = _passwords[index];
                return ListTile(
                  leading: const Icon(Icons.vpn_key),
                  title: Text(password.website),
                  subtitle: Text(password.username),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deletePassword(index),
                  ),
                  onTap: () => _navigateAndEditPassword(context, password, index),
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
