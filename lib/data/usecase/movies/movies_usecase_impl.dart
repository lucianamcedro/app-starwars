import 'package:desafio_starwars_flutter/starwars.dart';

class MoviesUsecaseImpl implements MoviesUsecase {
  final MoviesRepository moviesRepository;

  MoviesUsecaseImpl({required this.moviesRepository});

  @override
  Future<List<MoviesModel>> getMovies() {
    return moviesRepository.getMovies();
  }
}
