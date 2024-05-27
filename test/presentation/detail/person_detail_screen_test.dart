import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/person_model_mock.dart';

void main() {
  testWidgets('PersonDetailScreen displays person details',
      (WidgetTester tester) async {
    final model = PersonModelMock;

    await tester.pumpWidget(MaterialApp(
      home: PersonDetailScreen(person: PersonModelMock),
    ));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Padding), findsNWidgets(13));
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.text(model.name), findsOneWidget);
    expect(find.text(model.birthYear), findsOneWidget);
    expect(find.text(model.gender), findsOneWidget);
  });
}
