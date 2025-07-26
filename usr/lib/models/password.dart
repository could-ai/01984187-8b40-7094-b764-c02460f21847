class Password {
  final String id;
  final String website;
  final String username;
  final String password;
  final String categoryId; // 添加分类ID字段
  final String categoryName; // 添加分类名称字段，便于显示

  Password({
    required this.id,
    required this.website,
    required this.username,
    required this.password,
    required this.categoryId,
    this.categoryName = '', // 默认空字符串
  });
}

class Category {
  final String id;
  final String name;
  final String color;

  Category({
    required this.id,
    required this.name,
    this.color = 'blue', // 默认颜色
  });
}