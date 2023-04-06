part of 'person_favorites_bloc.dart';

abstract class PersonFavoritesState {}

class PersonFavoritesInitialState extends PersonFavoritesState {}

class PersonFavoritesLoadingState extends PersonFavoritesState {}

class PersonFavoritesSuccessState extends PersonFavoritesState {
  final List<PersonFavorites> personagem;

  PersonFavoritesSuccessState({required this.personagem});
}

class PersonFavoritesErrorState extends PersonFavoritesState {
  final String error;

  PersonFavoritesErrorState({required this.error});
}
