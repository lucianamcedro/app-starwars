import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final person = PersonModel(
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

  testWidgets('PersonDetailScreen displays person details',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PersonDetailScreen(person: person),
    ));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Padding), findsNWidgets(2));
    expect(find.byType(Column), findsOneWidget);
    expect(find.text('Name: Luke Skywalker'), findsOneWidget);
    expect(find.text('Birth Year: 19BBY'), findsOneWidget);
    expect(find.text('Gender: Male'), findsOneWidget);
    expect(find.text('Detalhes'), findsOneWidget);
  });
}
