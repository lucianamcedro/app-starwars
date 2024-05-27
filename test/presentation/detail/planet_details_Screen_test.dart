import 'package:desafio_starwars_flutter/presentation/detail/planet_details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/planet_model_mock.dart';

void main() {
  testWidgets('PlanetDetailsScreen displays planet details',
      (WidgetTester tester) async {
    final planetModel = PlanetModelMock;

    await tester.pumpWidget(MaterialApp(
      home: PlanetDetailsScreen(planetModel: planetModel),
    ));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(Padding), findsWidgets);

    expect(find.text(planetModel.name), findsOneWidget);
    expect(find.text(planetModel.population), findsOneWidget);
    expect(find.text(planetModel.climate), findsOneWidget);
    expect(find.text(planetModel.diameter), findsOneWidget);
    expect(find.text(planetModel.orbitalPeriod), findsOneWidget);
    expect(find.text(planetModel.rotationPeriod), findsOneWidget);
    expect(find.text(planetModel.surfaceWater), findsOneWidget);
  });
}
