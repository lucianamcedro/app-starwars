part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class OnLoadFavorites extends FavoritesEvent {}

class OnAddFavorite extends FavoritesEvent {
  final Favorites favorite;

  OnAddFavorite({required this.favorite});
}

class OnRemoveFavorite extends FavoritesEvent {
  final Favorites favorite;

  OnRemoveFavorite({required this.favorite});
}
