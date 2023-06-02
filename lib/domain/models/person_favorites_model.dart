import 'dart:convert';

class PersonFavorites {
  final String name;

  PersonFavorites({
    required this.name,
  });

  PersonFavorites copyWith({
    String? name,
  }) {
    return PersonFavorites(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory PersonFavorites.fromMap(Map<String, dynamic> map) {
    return PersonFavorites(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonFavorites.fromJson(String source) =>
      PersonFavorites.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PersonFavorites(name: $name)';

  @override
  bool operator ==(covariant PersonFavorites other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
