import 'dart:developer';
import 'package:desafio_starwars_flutter/domain/models/planet_model.dart';
import 'package:desafio_starwars_flutter/domain/shared/const.dart';
import 'package:dio/dio.dart';
import 'planet_repository.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  @override
  Future<List<Planet>> getPlanets() async {
    try {
      dynamic result;
      result = await Dio().get(ApiConsts.baseUrlPlanets);
      final dados = result.data['results'] as List;
      final planetsMapsList = dados.map((e) => Planet.fromMap(e)).toList();

      return planetsMapsList;
    } on DioError catch (e) {
      log('Erro ao buscar dados', error: e);
      throw Exception('Erro ao buscar dados');
    }
  }
}
