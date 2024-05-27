import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Movies', () {
    test('fromJson() and toJson()', () {
      final Map<String, dynamic> testData = {
        "title": "A New Hope",
        "episode_id": 4,
        "opening_crawl": "It is a period of civil war...",
        "director": "George Lucas",
        "producer": "Gary Kurtz, Rick McCallum",
        "release_date": "1977-05-25",
        "characters": ["https://swapi.dev/api/people/1/"],
        "planets": ["https://swapi.dev/api/planets/1/"],
        "starships": ["https://swapi.dev/api/starships/2/"],
        "vehicles": ["https://swapi.dev/api/vehicles/4/"],
        "species": ["https://swapi.dev/api/species/1/"],
        "created": "2014-12-10T14:23:31.880000Z",
        "edited": "2014-12-20T19:49:45.256000Z",
        "url": "https://swapi.dev/api/films/1/"
      };

      final movies = MoviesModel.fromMapJson(testData);
      final moviesFromJson = MoviesModel.fromJson(movies.toJson());
      expect(moviesFromJson.title, testData["title"]);
      expect(moviesFromJson.episodeId, testData["episode_id"]);
      expect(moviesFromJson.openingCrawl, testData["opening_crawl"]);
      expect(moviesFromJson.director, testData["director"]);
      expect(moviesFromJson.producer, testData["producer"]);
      expect(moviesFromJson.releaseDate.toIso8601String(),
          testData["release_date"]);
      expect(moviesFromJson.characters, testData["characters"]);
      expect(moviesFromJson.planets, testData["planets"]);
      expect(moviesFromJson.starships, testData["starships"]);
      expect(moviesFromJson.vehicles, testData["vehicles"]);
      expect(moviesFromJson.species, testData["species"]);
      expect(moviesFromJson.created.toString(), testData["created"]);
      expect(moviesFromJson.created.toString(), testData["edited"]);
      expect(moviesFromJson.url, testData["url"]);
    });
  });
}
