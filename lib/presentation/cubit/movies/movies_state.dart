part of 'movies_cubit.dart';

abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesSuccessState extends MoviesState {
  final List<Movies> movies;

  MoviesSuccessState({required this.movies});
}

class MoviesErrorState extends MoviesState {
  final String error;

  MoviesErrorState({required this.error});
}
