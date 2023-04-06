part of 'person_favorites_bloc.dart';

abstract class PersonFavoritesEvent {}

class OnLoadPersonFavorites extends PersonFavoritesEvent {}

class OnAddPersonFavorite extends PersonFavoritesEvent {
  final PersonFavorites personFavorite;

  OnAddPersonFavorite({required this.personFavorite});
}

class OnRemovePersonFavorite extends PersonFavoritesEvent {
  final PersonFavorites personFavorite;

  OnRemovePersonFavorite({required this.personFavorite});
}
