import 'package:desafio_starwars_flutter/starwars.dart';

class PlanetUsecaseImpl implements PlanetUsecase {
  final PlanetRepository planetRepository;

  PlanetUsecaseImpl({required this.planetRepository});

  @override
  Future<List<Planet>> getPlanets() {
    return planetRepository.getPlanets();
  }
}
