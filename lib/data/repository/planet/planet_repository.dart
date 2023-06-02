import 'package:desafio_starwars_flutter/starwars.dart';

abstract class PlanetRepository {
  Future<List<Planet>> getPlanets();
}
