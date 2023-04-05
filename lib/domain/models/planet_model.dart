import 'dart:convert';

class Planet {
  final String name;
  final String rotationPeriod;
  final String orbitalPeriod;
  final String diameter;
  final String climate;
  final String gravity;
  final String terrain;
  final String surfaceWater;
  final String population;
  final List<String> films;
  final String created;
  final String edited;
  final String url;

  Planet({
    required this.name,
    required this.rotationPeriod,
    required this.orbitalPeriod,
    required this.diameter,
    required this.climate,
    required this.gravity,
    required this.terrain,
    required this.surfaceWater,
    required this.population,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      rotationPeriod: json['rotation_period'],
      orbitalPeriod: json['orbital_period'],
      diameter: json['diameter'],
      climate: json['climate'],
      gravity: json['gravity'],
      terrain: json['terrain'],
      surfaceWater: json['surface_water'],
      population: json['population'],
      films: List<String>.from(json['films']),
      created: json['created'],
      edited: json['edited'],
      url: json['url'],
    );
  }

  factory Planet.fromMap(Map<String, dynamic> map) {
    return Planet(
      name: map['name'],
      rotationPeriod: map['rotationPeriod'],
      orbitalPeriod: map['orbitalPeriod'],
      diameter: map['diameter'],
      climate: map['climate'],
      gravity: map['gravity'],
      terrain: map['terrain'],
      surfaceWater: map['surfaceWater'],
      population: map['population'],
      films: List<String>.from(map['films']),
      created: map['created'],
      edited: map['edited'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rotationPeriod': rotationPeriod,
      'orbitalPeriod': orbitalPeriod,
      'diameter': diameter,
      'climate': climate,
      'gravity': gravity,
      'terrain': terrain,
      'surfaceWater': surfaceWater,
      'population': population,
      'films': films,
      'created': created,
      'edited': edited,
      'url': url,
    };
  }

  String toJson() => json.encode(toMap());
}
