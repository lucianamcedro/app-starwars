class Favorites {
  final String name;
  final String category;

  Favorites({required this.name, required this.category});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
    };
  }

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      name: json['name'],
      category: json['category'],
    );
  }
}
