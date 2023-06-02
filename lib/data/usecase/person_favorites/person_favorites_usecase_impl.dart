import 'package:desafio_starwars_flutter/data/repository/repository.dart';
import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';

import 'person_favorites_usecase.dart';

class PersonFavoritesUsecaseImpl implements PersonFavoritesUsecase {
  final PersonFavoritesRepository personFavoritesRepository;

  PersonFavoritesUsecaseImpl({required this.personFavoritesRepository});

  @override
  Future<List<PersonFavorites>> getFavoritePerson() {
    return personFavoritesRepository.getFavoritePerson();
  }

  @override
  Future<void> setFavoritePerson(List<PersonFavorites> favorites) {
    return personFavoritesRepository.setFavoritePerson(favorites);
  }
}
