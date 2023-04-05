import 'package:desafio_starwars_flutter/domain/models/planet_model.dart';

abstract class PlanetRepository {
  Future<List<Planet>> getPlanets();
}
