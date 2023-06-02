import 'package:desafio_starwars_flutter/starwars.dart';

abstract class PersonFavoritesRepository {
  Future<List<PersonFavorites>> getFavoritePerson();
  Future<void> addPersonFavorite(PersonFavorites personFavorite);
  Future<void> removePersonFavorite(PersonFavorites personFavorites);
  Future<void> setFavoritePerson(List<PersonFavorites> favorites);
}
