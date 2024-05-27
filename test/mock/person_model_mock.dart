import 'package:desafio_starwars_flutter/domain/models/models.dart';

final PersonModelMock = PersonModel(
  name: "Luke Skywalker",
  birthYear: '19BBY',
  gender: 'Male',
  height: "172",
  mass: "77",
  hairColor: "blond",
  skinColor: "fair",
  eyeColor: "blue",
  homeworld: "https://swapi.dev/api/planets/1/",
  films: [
    "https://swapi.dev/api/films/2/",
    "https://swapi.dev/api/films/6/",
    "https://swapi.dev/api/films/3/",
    "https://swapi.dev/api/films/1/",
    "https://swapi.dev/api/films/7/"
  ],
  species: ["https://swapi.dev/api/species/1/"],
  vehicles: [
    "https://swapi.dev/api/vehicles/14/",
    "https://swapi.dev/api/vehicles/30/"
  ],
  starships: [
    "https://swapi.dev/api/starships/12/",
    "https://swapi.dev/api/starships/22/"
  ],
  created: DateTime.now(),
  edited: DateTime.now(),
  url: "https://swapi.dev/api/people/1/",
);
