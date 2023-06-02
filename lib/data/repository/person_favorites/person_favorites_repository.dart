import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';

abstract class PersonFavoritesRepository {
  Future<List<PersonFavorites>> getFavoritePerson();
  Future<void> addPersonFavorite(PersonFavorites personFavorite);
  Future<void> removePersonFavorite(PersonFavorites personFavorites);
  Future<void> setFavoritePerson(List<PersonFavorites> favorites);
}
