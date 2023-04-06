import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';

abstract class PersonFavoritesUsecase {
  Future<List<PersonFavorites>> getFavoritePerson();
  Future<void> toggleFavorite(PersonFavorites personFavorites);
  Future<void> addPersonFavorite(PersonFavorites personFavorites);
  Future<void> removePersonFavorite(PersonFavorites personFavorites);
}
