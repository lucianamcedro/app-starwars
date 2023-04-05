import 'package:desafio_starwars_flutter/data/repository/repository.dart';
import 'package:desafio_starwars_flutter/domain/models/planet_model.dart';

import './planet_usecase.dart';

class PlanetUsecaseImpl implements PlanetUsecase {
  final PlanetRepository planetRepository;

  PlanetUsecaseImpl({required this.planetRepository});

  @override
  Future<List<Planet>> getPlanets() {
    return planetRepository.getPlanets();
  }
}
