import 'package:desafio_starwars_flutter/starwars.dart';

abstract class MoviesRepository {
  Future<List<MoviesModel>> getMovies();
}
