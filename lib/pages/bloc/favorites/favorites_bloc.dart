import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesUsecase favoritesUsecase;

  FavoritesBloc({required this.favoritesUsecase})
      : super(FavoritesInitialState()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is OnLoadFavorites) {
        try {
          final favorites = await favoritesUsecase.getFavorite();
          emit(FavoritesSuccessState(favorite: favorites.toList()));
        } on DioError catch (error) {
          emit(FavoritesErrorState(error: error.message!));
        }
      }
      if (event is OnAddFavorite) {
        try {
          final favorites = await favoritesUsecase.getFavorite();
          final index = favorites.indexWhere(
            (favorite) => favorite.name == event.favorite.name,
          );
          if (index >= 0) {
            favorites.removeAt(index);
            await favoritesUsecase.setFavoriteItem(favorites);
            emit(FavoritesSuccessState(favorite: favorites.toList()));
          } else {
            favorites.add(event.favorite);
            await favoritesUsecase.setFavoriteItem(favorites);
            emit(FavoritesSuccessState(favorite: favorites.toList()));
          }
        } on DioError catch (error) {
          emit(FavoritesErrorState(error: error.message!));
        }
      }
      if (event is OnRemoveFavorite) {
        try {
          final favorites = await favoritesUsecase.getFavorite();
          final index = favorites.indexWhere(
            (favorite) => favorite.name == event.favorite.name,
          );
          if (index >= 0) {
            favorites.removeAt(index);
            await favoritesUsecase.setFavoriteItem(favorites);
            emit(FavoritesSuccessState(favorite: favorites.toList()));
          }
        } on DioError catch (error) {
          emit(FavoritesErrorState(error: error.message!));
        }
      }
    });
  }
}
