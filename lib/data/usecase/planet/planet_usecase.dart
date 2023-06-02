import 'package:desafio_starwars_flutter/starwars.dart';

abstract class PlanetUsecase {
  Future<List<Planet>> getPlanets();
}
