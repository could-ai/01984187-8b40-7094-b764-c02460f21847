import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final List<Category> categories;

  const SettingsScreen({super.key, required this.categories});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late List<Category> _categories;
  final _categoryFormKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categories = List.from(widget.categories);
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  void _addCategory() {
    if (_categoryFormKey.currentState!.validate()) {
      final newCategory = Category(
        id: DateTime.now().toIso8601String(),
        name: _categoryNameController.text,
      );
      setState(() {
        _categories.add(newCategory);
      });
      _categoryNameController.clear();
      Navigator.pop(context); // Close the dialog
    }
  }

  void _editCategory(Category categoryToEdit) {
    _categoryNameController.text = categoryToEdit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Category'),
        content: Form(
          key: _categoryFormKey,
          child: TextFormField(
            controller: _categoryNameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _categoryNameController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_categoryFormKey.currentState!.validate()) {
                setState(() {
                  final index = _categories.indexWhere((c) => c.id == categoryToEdit.id);
                  if (index != -1) {
                    _categories[index] = Category(id: categoryToEdit.id, name: _categoryNameController.text);
                  }
                });
                _categoryNameController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(Category categoryToDelete) {
    setState(() {
      _categories.removeWhere((c) => c.id == categoryToDelete.id);
    });
  }

  void _showAddCategoryDialog() {
    _categoryNameController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Category'),
        content: Form(
          key: _categoryFormKey,
          child: TextFormField(
            controller: _categoryNameController,
            decoration: const InputDecoration(labelText: 'Category Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addCategory,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _categories),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Manage Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _showAddCategoryDialog,
                  child: const Text('Add New'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return ListTile(
                  title: Text(category.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editCategory(category),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteCategory(category),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});
}
