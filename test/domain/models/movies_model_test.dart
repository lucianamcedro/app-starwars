import 'dart:convert';
import 'package:desafio_starwars_flutter/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MoviesModel', () {
    test('fromJson', () {
      final Map<String, dynamic> jsonData = {
        'title': 'A New Hope',
        'episode_id': 4,
        'opening_crawl': 'It is a period of civil war.',
        'director': 'George Lucas',
        'producer': 'Gary Kurtz, Rick McCallum',
        'release_date': '1977-05-25',
        'characters': ['Luke Skywalker', 'Leia Organa', 'Han Solo'],
        'planets': ['Tatooine', 'Alderaan', 'Yavin IV'],
        'starships': ['X-wing', 'TIE Fighter', 'Star Destroyer'],
        'vehicles': ['Sand Crawler', 'X-34 landspeeder', 'TIE/LN starfighter'],
        'species': ['Human', 'Droid', 'Wookiee'],
        'created': '2021-01-01T00:00:00.000Z',
        'edited': '2021-01-01T00:00:00.000Z',
        'url': 'https://swapi.dev/api/films/1/',
      };

      final moviesModel = MoviesModel.fromMap(jsonData);

      final expectedJson = json.encode({
        'title': 'A New Hope',
        'episode_id': 4,
        'opening_crawl': 'It is a period of civil war.',
        'director': 'George Lucas',
        'producer': 'Gary Kurtz, Rick McCallum',
        'release_date': '1977-05-25T00:00:00.000',
        'characters': ['Luke Skywalker', 'Leia Organa', 'Han Solo'],
        'planets': ['Tatooine', 'Alderaan', 'Yavin IV'],
        'starships': ['X-wing', 'TIE Fighter', 'Star Destroyer'],
        'vehicles': ['Sand Crawler', 'X-34 landspeeder', 'TIE/LN starfighter'],
        'species': ['Human', 'Droid', 'Wookiee'],
        'created': '2021-01-01T00:00:00.000Z',
        'edited': '2021-01-01T00:00:00.000Z',
        'url': 'https://swapi.dev/api/films/1/',
      });

      expect(moviesModel.toJson(), expectedJson);
    });
  });
}
