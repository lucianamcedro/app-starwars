import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesUsecase favoritesUsecase;

  FavoritesCubit({required this.favoritesUsecase})
      : super(FavoritesInitialState());

  Future<void> loadFavorites() async {
    emit(PersonFavoritesLoadingState());
    try {
      final favorites = await favoritesUsecase.getFavorite();
      emit(FavoritesSuccessState(favorite: favorites.toList()));
    } on DioException catch (error) {
      emit(FavoritesErrorState(error: error.message!));
    }
  }

  Future<void> addFavorite(favorite) async {
    try {
      final favorites = await favoritesUsecase.getFavorite();
      final index = favorites.indexWhere(
        (fav) => fav.name == favorite.name,
      );
      if (index >= 0) {
        favorites.removeAt(index);
      } else {
        favorites.add(favorite);
      }
      await favoritesUsecase.setFavoriteItem(favorites);
      emit(FavoritesSuccessState(favorite: favorites.toList()));
    } on DioException catch (error) {
      emit(FavoritesErrorState(error: error.message!));
    }
  }

  Future<void> removeFavorite(favorite) async {
    try {
      final favorites = await favoritesUsecase.getFavorite();
      final index = favorites.indexWhere(
        (fav) => fav.name == favorite.name,
      );
      if (index >= 0) {
        favorites.removeAt(index);
        await favoritesUsecase.setFavoriteItem(favorites);
        emit(FavoritesSuccessState(favorite: favorites.toList()));
      }
    } on DioException catch (error) {
      emit(FavoritesErrorState(error: error.message!));
    }
  }
}
