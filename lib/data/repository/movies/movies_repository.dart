import 'package:desafio_starwars_flutter/domain/models/movies_model.dart';

abstract class MoviesRepository {
  Future<List<Movies>> getMovies();
}