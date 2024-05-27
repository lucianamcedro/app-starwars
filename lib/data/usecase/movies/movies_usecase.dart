import 'package:desafio_starwars_flutter/starwars.dart';

abstract class MoviesUsecase {
  Future<List<MoviesModel>> getMovies();
}
