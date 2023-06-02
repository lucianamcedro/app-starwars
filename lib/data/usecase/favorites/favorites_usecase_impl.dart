import 'package:desafio_starwars_flutter/data/repository/repository.dart';
import 'package:desafio_starwars_flutter/domain/models/favorites_model.dart';

import 'favorites_usecase.dart';

class FavoritesUsecaseImpl implements FavoritesUsecase {
  final FavoritesRepository favoritesRepository;

  FavoritesUsecaseImpl({required this.favoritesRepository});

  @override
  Future<List<Favorites>> getFavorite() {
    return favoritesRepository.getFavorite();
  }

  @override
  Future<void> setFavoriteItem(List<Favorites> favorite) {
    return favoritesRepository.setFavoriteItem(favorite);
  }
}
