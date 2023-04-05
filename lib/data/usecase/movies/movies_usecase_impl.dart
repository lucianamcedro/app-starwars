import 'package:desafio_starwars_flutter/data/repository/repository.dart';
import 'package:desafio_starwars_flutter/domain/models/movies_model.dart';

import './movies_usecase.dart';

class MoviesUsecaseImpl implements MoviesUsecase {
  final MoviesRepository moviesRepository;

  MoviesUsecaseImpl({required this.moviesRepository});
  @override
  Future<List<Movies>> getMovies() {
    return moviesRepository.getMovies();
  }
}
