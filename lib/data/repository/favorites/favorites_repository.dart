import 'package:desafio_starwars_flutter/starwars.dart';

abstract class FavoritesRepository {
  Future<List<Favorites>> getFavorite();
  Future<void> addItemFavorite(Favorites favorite);
  Future<void> removeItemFavorite(Favorites favorite);
  Future<void> setFavoriteItem(List<Favorites> favorite);
}
