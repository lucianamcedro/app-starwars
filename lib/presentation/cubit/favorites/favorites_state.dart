part of 'favorites_cubit.dart';

abstract class FavoritesState {}

class FavoritesInitialState extends FavoritesState {}

class PersonFavoritesLoadingState extends FavoritesState {}

class FavoritesSuccessState extends FavoritesState {
  final List<Favorites> favorite;

  FavoritesSuccessState({required this.favorite});
}

class FavoritesErrorState extends FavoritesState {
  final String error;

  FavoritesErrorState({required this.error});
}
