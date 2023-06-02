import 'dart:convert';

class Favorites {
  final String name;

  Favorites({
    required this.name,
  });

  Favorites copyWith({
    String? name,
  }) {
    return Favorites(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Favorites.fromMap(Map<String, dynamic> map) {
    return Favorites(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorites.fromJson(String source) =>
      Favorites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Favorites(name: $name)';

  @override
  bool operator ==(covariant Favorites other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
