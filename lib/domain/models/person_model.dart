// ignore_for_file: public_member_api_docs, sort_constructors_first

class Person {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeworld;
  final List<String> films;
  final List<String> species;
  final List<String> vehicles;
  final List<String> starships;
  final DateTime created;
  final DateTime edited;
  final String url;

  Person({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      homeworld: json['homeworld'],
      films: List<String>.from(json['films']),
      species: List<String>.from(json['species']),
      vehicles: List<String>.from(json['vehicles']),
      starships: List<String>.from(json['starships']),
      created: DateTime.parse(json['created']),
      edited: DateTime.parse(json['edited']),
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'height': height,
      'mass': mass,
      'hair_color': hairColor,
      'skin_color': skinColor,
      'eye_color': eyeColor,
      'birth_year': birthYear,
      'gender': gender,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'vehicles': vehicles,
      'starships': starships,
      'created': created.toIso8601String(),
      'edited': edited.toIso8601String(),
      'url': url,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'height': height,
      'mass': mass,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'eyeColor': eyeColor,
      'birthYear': birthYear,
      'gender': gender,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'vehicles': vehicles,
      'starships': starships,
      'created': created.millisecondsSinceEpoch,
      'edited': edited.millisecondsSinceEpoch,
      'url': url,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'],
      height: map['height'],
      mass: map['mass'],
      hairColor: map['hair_color'],
      skinColor: map['skin_color'],
      eyeColor: map['eye_color'],
      birthYear: map['birth_year'],
      gender: map['gender'],
      homeworld: map['homeworld'],
      films: List<String>.from(map['films']),
      species: List<String>.from(map['species']),
      vehicles: List<String>.from(map['vehicles']),
      starships: List<String>.from(map['starships']),
      created: DateTime.parse(map['created']),
      edited: DateTime.parse(map['edited']),
      url: map['url'],
    );
  }
}
