import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesUsecase moviesUsecase;

  MoviesCubit({required this.moviesUsecase}) : super(MoviesInitialState());

  Future<void> loadMovies() async {
    emit(MoviesLoadingState());
    try {
      final movies = await moviesUsecase.getMovies();
      emit(MoviesSuccessState(movies: movies));
    } on DioException catch (error) {
      emit(MoviesErrorState(error: error.message!));
    }
  }
}
