import 'dart:convert';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlanetModel', () {
    test('fromJson() should correctly parse a JSON map', () {
      final json = {
        'name': 'Tatooine',
        'rotation_period': '23',
        'orbital_period': '304',
        'diameter': '10465',
        'climate': 'arid',
        'gravity': '1 standard',
        'terrain': 'desert',
        'surface_water': '1',
        'population': '200000',
        'films': ['https://swapi.dev/api/films/1/'],
        'created': '2014-12-09T13:50:49.641000Z',
        'edited': '2014-12-20T20:58:18.411000Z',
        'url': 'https://swapi.dev/api/planets/1/'
      };

      final expectedMap = {
        'name': 'Tatooine',
        'rotation_period': '23',
        'orbital_period': '304',
        'diameter': '10465',
        'climate': 'arid',
        'gravity': '1 standard',
        'terrain': 'desert',
        'surface_water': '1',
        'population': '200000',
        'films': ['https://swapi.dev/api/films/1/'],
        'created': '2014-12-09T13:50:49.641000Z',
        'edited': '2014-12-20T20:58:18.411000Z',
        'url': 'https://swapi.dev/api/planets/1/'
      };

      final planet = PlanetModel.fromJson(json);

      expect(planet.name, 'Tatooine');
      expect(planet.rotationPeriod, '23');
      expect(planet.orbitalPeriod, '304');
      expect(planet.diameter, '10465');
      expect(planet.climate, 'arid');
      expect(planet.gravity, '1 standard');
      expect(planet.terrain, 'desert');
      expect(planet.surfaceWater, '1');
      expect(planet.population, '200000');
      expect(planet.films, ['https://swapi.dev/api/films/1/']);
      expect(planet.created, '2014-12-09T13:50:49.641000Z');
      expect(planet.edited, '2014-12-20T20:58:18.411000Z');
      expect(planet.url, 'https://swapi.dev/api/planets/1/');

      final actualMap = planet.toMap();
      final actualJson = jsonEncode(actualMap);

      expect(jsonDecode(actualJson), expectedMap);
    });

    test('toJson() should correctly encode a PlanetModel instance to JSON', () {
      final planet = PlanetModel(
          name: 'Tatooine',
          rotationPeriod: '23',
          orbitalPeriod: '304',
          diameter: '10465',
          climate: 'arid',
          gravity: '1 standard',
          terrain: 'desert',
          surfaceWater: '1',
          population: '200000',
          films: ['https://swapi.dev/api/films/1/'],
          created: '2014-12-09T13:50:49.641000Z',
          edited: '2014-12-20T20:58:18.411000Z',
          url: 'https://swapi.dev/api/planets/1/');

      final json = planet.toJson();

      final expectedJson = {
        'name': 'Tatooine',
        'rotation_period': '23',
        'orbital_period': '304',
        'diameter': '10465',
        'climate': 'arid',
        'gravity': '1 standard',
        'terrain': 'desert',
        'surface_water': '1',
        'population': '200000',
        'films': ['https://swapi.dev/api/films/1/'],
        'created': '2014-12-09T13:50:49.641000Z',
        'edited': '2014-12-20T20:58:18.411000Z',
        'url': 'https://swapi.dev/api/planets/1/'
      };

      expect(jsonDecode(json), expectedJson);
    });
  });
}
