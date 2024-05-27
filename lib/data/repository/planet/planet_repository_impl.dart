import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  static const String cacheKey = 'planet_cache';

  @override
  Future<List<PlanetModel>> getPlanets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      try {
        final decodedData = jsonDecode(cachedData);
        if (decodedData is List) {
          final planetMapsList = decodedData
              .map((e) => PlanetModel.fromMap(Map<String, dynamic>.from(e)))
              .toList();

          return planetMapsList;
        }
      } catch (e) {
        log('Erro ao decodificar dados do cache', error: e);
      }
    }

    try {
      final List<PlanetModel> allPlanets = [];

      for (int i = 1; i <= 60; i++) {
        try {
          final response = await Dio().get('${ApiConsts.baseUrlPlanets}/$i');
          final data = response.data;

          final planet = PlanetModel.fromMap(data);
          allPlanets.add(planet);
        } catch (e) {
          log('Erro ao buscar dados do planeta $i', error: e);
        }
      }

      final planetMapsList =
          allPlanets.map((planet) => planet.toMap()).toList();
      final cachedData = jsonEncode(planetMapsList);
      await prefs.setString(cacheKey, cachedData);

      return allPlanets;
    } on DioException catch (e) {
      log('Erro ao buscar dados', error: e);
      throw Exception('Erro ao buscar dados');
    }
  }
}
