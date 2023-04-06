import 'package:desafio_starwars_flutter/data/usecase/usecase.dart';
import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';
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

          emit(PersonFavoritesSuccessState(personagem: favorites));
        } on DioError catch (error) {
          emit(PersonFavoritesErrorState(error: error.message!));
        }
      }
      if (event is OnAddPersonFavorite) {
        try {
          await personFavoritesUsecase.addPersonFavorite(event.personFavorite);

          final favorites = await personFavoritesUsecase.getFavoritePerson();

          emit(PersonFavoritesSuccessState(personagem: favorites));
        } on DioError catch (error) {
          emit(PersonFavoritesErrorState(error: error.message!));
        }
      }
      if (event is OnRemovePersonFavorite) {
        try {
          await personFavoritesUsecase
              .removePersonFavorite(event.personFavorite);

          final favorites = await personFavoritesUsecase.getFavoritePerson();

          emit(PersonFavoritesSuccessState(personagem: favorites));
        } on DioError catch (error) {
          emit(PersonFavoritesErrorState(error: error.message!));
        }
      }
    });
  }
}
