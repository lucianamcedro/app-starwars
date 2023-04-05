import 'dart:convert';

class Movies {
  String title;
  int episodeId;
  String openingCrawl;
  String director;
  String producer;
  DateTime releaseDate;
  List<String> characters;
  List<String> planets;
  List<String> starships;
  List<String> vehicles;
  List<String> species;
  DateTime created;
  DateTime edited;
  String url;

  Movies({
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.characters,
    required this.planets,
    required this.starships,
    required this.vehicles,
    required this.species,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Movies.fromMap(Map<String, dynamic> map) {
    return Movies(
      title: map['title'],
      episodeId: map['episode_id'],
      openingCrawl: map['opening_crawl'],
      director: map['director'],
      producer: map['producer'],
      releaseDate: DateTime.parse(map['release_date']),
      characters: List<String>.from(map['characters']),
      planets: List<String>.from(map['planets']),
      starships: List<String>.from(map['starships']),
      vehicles: List<String>.from(map['vehicles']),
      species: List<String>.from(map['species']),
      created: DateTime.parse(map['created']),
      edited: DateTime.parse(map['edited']),
      url: map['url'],
    );
  }

  factory Movies.fromJson(String json) {
    return Movies.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'episode_id': episodeId,
      'opening_crawl': openingCrawl,
      'director': director,
      'producer': producer,
      'release_date': releaseDate.toIso8601String(),
      'characters': characters,
      'planets': planets,
      'starships': starships,
      'vehicles': vehicles,
      'species': species,
      'created': created.toIso8601String(),
      'edited': edited.toIso8601String(),
      'url': url,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
