import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desafio_starwars_flutter/starwars.dart';

class PersonFavoritesRepositoryImpl implements FavoritesRepository {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<List<Favorites>> getFavorite() async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    return favorites.map((fav) => Favorites.fromJson(jsonDecode(fav))).toList();
  }

  @override
  Future<void> addItemFavorite(Favorites itemFavorite) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    final index = favorites.indexWhere((fav) {
      final favorite = jsonDecode(fav);
      return (favorite is Map) && (favorite['name'] == itemFavorite.name);
    });

    if (index < 0) {
      final favorite = Favorites(
        category: itemFavorite.category,
        name: itemFavorite.name,
      );
      favorites.add(jsonEncode(favorite.toJson()));

      await prefs.setStringList('favorites', favorites);
    }
  }

  @override
  Future<void> removeItemFavorite(Favorites itemFavorite) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    final index = favorites.indexWhere((fav) {
      try {
        final favorite = jsonDecode(fav);
        return favorite['name'] == itemFavorite.name;
      } catch (e) {
        print('Error decoding JSON string: $fav');
        return false;
      }
    });

    if (index >= 0) {
      favorites.removeAt(index);
      await prefs.setStringList('favorites', favorites);
    }
  }

  @override
  Future<void> setFavoriteItem(List<Favorites> itemFavorite) async {
    final prefs = await _prefs;
    final encodedFavorites = itemFavorite
        .map((itemFavorite) => jsonEncode(itemFavorite.toJson()))
        .toList();

    await prefs.setStringList('favorites', encodedFavorites);
  }
}
