import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';

abstract class PersonFavoritesUsecase {
  Future<List<PersonFavorites>> getFavoritePerson();
  Future<void> setFavoritePerson(List<PersonFavorites> favorites);
}
