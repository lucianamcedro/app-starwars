import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';
import 'person_favorites_repository.dart';

class PersonFavoritesRepositoryImpl implements PersonFavoritesRepository {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<List<PersonFavorites>> getFavoritePerson() async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    return favorites
        .map((fav) => PersonFavorites.fromJson(jsonDecode(fav)))
        .toList();
  }

  @override
  Future<void> addPersonFavorite(PersonFavorites personFavorite) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    final index = favorites.indexWhere((fav) {
      final favorite = jsonDecode(fav);
      return (favorite is Map) && (favorite['name'] == personFavorite.name);
    });

    if (index < 0) {
      final favorite = PersonFavorites(
        name: personFavorite.name,
      );
      favorites.add(jsonEncode(favorite.toJson()));

      await prefs.setStringList('favorites', favorites);
    }
  }

  @override
  Future<void> removePersonFavorite(PersonFavorites personFavorites) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    final index = favorites.indexWhere((fav) {
      try {
        final favorite = jsonDecode(fav);
        return favorite['name'] == personFavorites.name;
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
  Future<void> setFavoritePerson(List<PersonFavorites> favorites) async {
    final prefs = await _prefs;
    final encodedFavorites =
        favorites.map((favorite) => jsonEncode(favorite.toJson())).toList();

    await prefs.setStringList('favorites', encodedFavorites);
  }
}
