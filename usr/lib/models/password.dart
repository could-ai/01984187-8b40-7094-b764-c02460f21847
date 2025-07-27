class Password {
  final String id;
  final String website;
  final String username;
  final String password;
  final String categoryId;
  final String categoryName;
  final bool isFavorite; // Add isFavorite field

  Password({
    required this.id,
    required this.website,
    required this.username,
    required this.password,
    required this.categoryId,
    required this.categoryName,
    this.isFavorite = false, // Default to false
  });
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}
