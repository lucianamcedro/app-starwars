import 'package:desafio_starwars_flutter/presentation/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFavoritesCubit extends Mock implements FavoritesCubit {}

void main() {
  testWidgets('FavoritesPage displays favorites correctly',
      (WidgetTester tester) async {
    final mockFavoritesCubit = MockFavoritesCubit();

    when(mockFavoritesCubit.state)
        .thenAnswer((_) => FavoritesSuccessState(favorite: []));

    await tester.pumpWidget(MaterialApp(
      home: FavoritesPage(name: 'Test'),
    ));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
    expect(find.text('Nenhum favorito.'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
