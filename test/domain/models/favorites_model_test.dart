import 'package:desafio_starwars_flutter/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Favorites', () {
    test('fromJson', () {
      final Map<String, dynamic> jsonData = {
        'name': 'Favorite Name',
        'category': 'Favorite Category',
      };

      final favorites = Favorites.fromJson(jsonData);

      expect(favorites.name, 'Favorite Name');
      expect(favorites.category, 'Favorite Category');
    });

    test('toJson', () {
      final favorites =
          Favorites(name: 'Favorite Name', category: 'Favorite Category');

      final json = favorites.toJson();

      expect(json['name'], 'Favorite Name');
      expect(json['category'], 'Favorite Category');
    });
  });
}
