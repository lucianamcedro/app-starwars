import 'package:desafio_starwars_flutter/data/usecase/usecase.dart';
import 'package:desafio_starwars_flutter/domain/models/movies_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesUsecase moviesUsecase;

  MoviesBloc({required this.moviesUsecase}) : super(MoviesInitialState()) {
    on<MoviesEvent>((event, emit) async {
      if (event is OnLoadMovies) {
        try {
          final movies = await moviesUsecase.getMovies();

          emit(MoviesSuccessState(movies: movies));
        } on DioError catch (error) {
          emit(MoviesErrorState(error: error.message!));
        }
      }
    });
  }
}
