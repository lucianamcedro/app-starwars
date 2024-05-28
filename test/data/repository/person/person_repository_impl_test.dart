import 'dart:convert';

import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDio extends Mock implements Dio {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late PersonRepository repository;
  late MockDio mockDio;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockDio = MockDio();
    mockSharedPreferences = MockSharedPreferences();
    repository = PersonRepositoryImpl();
  });

  test('getPersons() should return a list of PersonModel', () async {
    // Mock SharedPreferences to return null, indicating no cached data
    when(mockSharedPreferences.getString('cache_data')).thenReturn(null);

    // Mock Dio to return sample data
    when(mockDio.get('${ApiConsts.baseUrlPerson}')).thenAnswer(
      (_) async => Response(
        data: {
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
          'url': 'https://swapi.dev/api/people/1/'
        },
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
      ),
    );

    final persons = await repository.getPersons();

    expect(persons, isNotEmpty);
    expect(persons.length, 1);
    expect(persons.first.name, 'Luke Skywalker');
  });

  test('getPersons() should return cached data if available', () async {
    final cachedData = jsonEncode([
      {
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
        'url': 'https://swapi.dev/api/people/1/'
      }
    ]);
    when(mockSharedPreferences.getString('cache_data')).thenReturn(cachedData);

    when(mockDio.get('${ApiConsts.baseUrlPerson}')).thenThrow(DioException(
      response: Response(
        statusCode: 404,
        requestOptions: RequestOptions(path: ''),
      ),
      requestOptions: RequestOptions(path: ''),
    ));

    final persons = await repository.getPersons();

    expect(persons, isNotEmpty);
    expect(persons.length, 1);
    expect(persons.first.name, 'Luke Skywalker');
  });
}
