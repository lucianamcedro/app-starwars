import 'package:desafio_starwars_flutter/domain/models/favorites_model.dart';

abstract class FavoritesUsecase {
  Future<List<Favorites>> getFavorite();
  Future<void> setFavoriteItem(List<Favorites> favorites);
}
