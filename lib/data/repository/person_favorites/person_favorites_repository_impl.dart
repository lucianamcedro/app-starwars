import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';

import './person_favorites_repository.dart';

class PersonFavoritesRepositoryImpl implements PersonFavoritesRepository {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<List<PersonFavorites>> getFavoritesPerson() async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    return favorites
        .map((fav) => PersonFavorites.fromJson(jsonDecode(fav)))
        .toList();
  }

  @override
  Future<void> toggleFavorite(PersonFavorites personFavorites) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    final index = favorites.indexWhere((fav) {
      final favorite = jsonDecode(fav);
      return favorite['name'] == personFavorites.name;
    });

    if (index >= 0) {
      favorites.removeAt(index);
    } else {
      final favorite = PersonFavorites(
        name: personFavorites.name,
      );
      favorites.add(jsonEncode(favorite.toJson()));
    }

    await prefs.setStringList('favorites', favorites);
  }

  @override
  Future<void> addPersonFavorite(PersonFavorites personFavorites) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList('favorites') ?? [];

    final index = favorites.indexWhere((fav) {
      final favorite = jsonDecode(fav);
      return favorite['name'] == personFavorites.name;
    });

    if (index < 0) {
      final favorite = PersonFavorites(
        name: personFavorites.name,
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
      final favorite = jsonDecode(fav);
      return favorite['name'] == personFavorites.name;
    });

    if (index >= 0) {
      favorites.removeAt(index);
      await prefs.setStringList('favorites', favorites);
    }
  }
}
