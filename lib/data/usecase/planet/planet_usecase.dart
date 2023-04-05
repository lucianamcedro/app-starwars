import 'package:desafio_starwars_flutter/domain/models/planet_model.dart';

abstract class PlanetUsecase {
  Future<List<Planet>> getPlanets();
}
