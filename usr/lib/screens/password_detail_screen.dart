import 'package:flutter/material.dart';
import '../models/password.dart';

class PasswordDetailScreen extends StatefulWidget {
  final Password? password;
  final List<Category> categories;

  const PasswordDetailScreen({super.key, this.password, required this.categories});

  @override
  _PasswordDetailScreenState createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _websiteController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String? _selectedCategoryId;
  bool _isPasswordVisible = false;
  bool _isFavorite = false; // Add state for favorite toggle

  @override
  void initState() {
    super.initState();
    _websiteController = TextEditingController(text: widget.password?.website ?? '');
    _usernameController = TextEditingController(text: widget.password?.username ?? '');
    _passwordController = TextEditingController(text: widget.password?.password ?? '');
    _isFavorite = widget.password?.isFavorite ?? false;

    if (widget.password != null) {
      _selectedCategoryId = widget.password!.categoryId;
    } else if (widget.categories.isNotEmpty) {
      // Exclude 'Favorites' from being a default selection
      _selectedCategoryId = widget.categories.firstWhere((c) => c.id != '0').id;
    }
  }

  @override
  void dispose() {
    _websiteController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _savePassword() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category.')),
        );
        return;
      }

      final selectedCategory = widget.categories.firstWhere((cat) => cat.id == _selectedCategoryId);

      final newPassword = Password(
        id: widget.password?.id ?? DateTime.now().toIso8601String(),
        website: _websiteController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        categoryId: _selectedCategoryId!,
        categoryName: selectedCategory.name,
        isFavorite: _isFavorite, // Save favorite status
      );
      Navigator.pop(context, newPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.password == null ? 'Add Password' : 'Edit Password'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePassword,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _websiteController,
                decoration: const InputDecoration(
                  labelText: 'Website or Service',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a website or service';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username or Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username or email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (widget.categories.isNotEmpty)
                DropdownButtonFormField<String>(
                  value: _selectedCategoryId,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  // Exclude 'Favorites' from selectable options
                  items: widget.categories
                      .where((c) => c.id != '0')
                      .map((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategoryId = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
              const SizedBox(height: 16),
              // Add toggle for 'isFavorite'
              SwitchListTile(
                title: const Text('Add to Favorites'),
                value: _isFavorite,
                onChanged: (bool value) {
                  setState(() {
                    _isFavorite = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
