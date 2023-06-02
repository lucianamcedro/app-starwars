import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_favorites_event.dart';
part 'person_favorites_state.dart';

class PersonFavoritesBloc
    extends Bloc<PersonFavoritesEvent, PersonFavoritesState> {
  final PersonFavoritesUsecase personFavoritesUsecase;

  PersonFavoritesBloc({required this.personFavoritesUsecase})
      : super(PersonFavoritesInitialState()) {
    on<PersonFavoritesEvent>((event, emit) async {
      if (event is OnLoadPersonFavorites) {
        try {
          final favorites = await personFavoritesUsecase.getFavoritePerson();
          emit(PersonFavoritesSuccessState(personagem: favorites.toList()));
        } on DioError catch (error) {
          emit(PersonFavoritesErrorState(error: error.message!));
        }
      }
      if (event is OnAddPersonFavorite) {
        try {
          final favorites = await personFavoritesUsecase.getFavoritePerson();
          final index = favorites.indexWhere(
            (favorite) => favorite.name == event.personFavorite.name,
          );
          if (index >= 0) {
            favorites.removeAt(index);
            await personFavoritesUsecase.setFavoritePerson(favorites);
            emit(PersonFavoritesSuccessState(personagem: favorites.toList()));
          } else {
            favorites.add(event.personFavorite);
            await personFavoritesUsecase.setFavoritePerson(favorites);
            emit(PersonFavoritesSuccessState(personagem: favorites.toList()));
          }
        } on DioError catch (error) {
          emit(PersonFavoritesErrorState(error: error.message!));
        }
      }
      if (event is OnRemovePersonFavorite) {
        try {
          final favorites = await personFavoritesUsecase.getFavoritePerson();
          final index = favorites.indexWhere(
            (favorite) => favorite.name == event.personFavorite.name,
          );
          if (index >= 0) {
            favorites.removeAt(index);
            await personFavoritesUsecase.setFavoritePerson(favorites);
            emit(PersonFavoritesSuccessState(personagem: favorites.toList()));
          }
        } on DioError catch (error) {
          emit(PersonFavoritesErrorState(error: error.message!));
        }
      }
    });
  }
}
