import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PersonModel', () {
    test('fromJson', () {
      final Map<String, dynamic> jsonData = {
        'name': 'Luke Skywalker',
        'height': '172',
        'mass': '77',
        'hair_color': 'blond',
        'skin_color': 'fair',
        'eye_color': 'blue',
        'birth_year': '19BBY',
        'gender': 'male',
        'homeworld': 'Tatooine',
        'films': ['https://swapi.dev/api/films/1/'],
        'species': ['https://swapi.dev/api/species/1/'],
        'vehicles': ['https://swapi.dev/api/vehicles/14/'],
        'starships': ['https://swapi.dev/api/starships/12/'],
        'created': '2014-12-09T13:50:51.644000Z',
        'edited': '2014-12-20T21:17:56.891000Z',
        'url': 'https://swapi.dev/api/people/1/',
      };

      final personModel = PersonModel.fromJson(jsonData);

      final expectedJson = {
        'name': 'Luke Skywalker',
        'height': '172',
        'mass': '77',
        'hair_color': 'blond',
        'skin_color': 'fair',
        'eye_color': 'blue',
        'birth_year': '19BBY',
        'gender': 'male',
        'homeworld': 'Tatooine',
        'films': ['https://swapi.dev/api/films/1/'],
        'species': ['https://swapi.dev/api/species/1/'],
        'vehicles': ['https://swapi.dev/api/vehicles/14/'],
        'starships': ['https://swapi.dev/api/starships/12/'],
        'created': DateTime.parse('2014-12-09T13:50:51.644000Z'),
        'edited': DateTime.parse('2014-12-20T21:17:56.891000Z'),
        'url': 'https://swapi.dev/api/people/1/',
      };

      expect(
          personModel.toJson(),
          expectedJson.map((key, value) => MapEntry(
              key, value is DateTime ? value.toIso8601String() : value)));
    });
  });
}
