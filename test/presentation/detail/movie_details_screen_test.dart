import 'package:desafio_starwars_flutter/presentation/detail/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/movie_model_mock.dart';

void main() {
  testWidgets('MovieDetailsScreen displays movie details',
      (WidgetTester tester) async {
    final moviesModel = MoviesModelMock;

    await tester.pumpWidget(MaterialApp(
      home: MovieDetailsScreen(moviesModel: moviesModel),
    ));
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Column), findsNWidgets(2));
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(Padding), findsWidgets);
    expect(find.text(moviesModel.title), findsOneWidget);
    expect(find.text(moviesModel.director), findsOneWidget);
    expect(find.text(moviesModel.producer), findsOneWidget);
    expect(find.text(moviesModel.openingCrawl), findsOneWidget);
  });
}
