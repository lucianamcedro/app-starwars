import 'package:desafio_starwars_flutter/data/repository/person_favorites/person_favorites.dart';
import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';

import './person_favorites_usecase.dart';

class PersonFavoritesUsecaseImpl implements PersonFavoritesUsecase {
  final PersonFavoritesRepository personFavoritesRepository;

  PersonFavoritesUsecaseImpl({required this.personFavoritesRepository});

  @override
  Future<List<PersonFavorites>> getFavoritePerson() {
    return personFavoritesRepository.getFavoritesPerson();
  }

  @override
  Future<void> toggleFavorite(PersonFavorites personFavorites) {
    return personFavoritesRepository.toggleFavorite(personFavorites);
  }

  @override
  Future<void> addPersonFavorite(PersonFavorites personFavorites) {
    return personFavoritesRepository.addPersonFavorite(personFavorites);
  }

  @override
  Future<void> removePersonFavorite(PersonFavorites personFavorites) {
    return personFavoritesRepository.removePersonFavorite(personFavorites);
  }
}
