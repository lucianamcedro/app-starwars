import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  static const String cacheKey = 'planet_cache';

  @override
  Future<List<Planet>> getPlanets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      try {
        final decodedData = jsonDecode(cachedData);
        if (decodedData is List) {
          final planetMapsList = decodedData
              .map((e) => Planet.fromMap(Map<String, dynamic>.from(e)))
              .toList();

          return planetMapsList;
        }
      } catch (e) {
        log('Erro ao decodificar dados do cache', error: e);
      }
    }

    try {
      final result = await Dio().get(ApiConsts.baseUrlPlanets);
      final dados = result.data['results'] as List;
      final planetMapsList = dados.map((e) => Planet.fromMap(e)).toList();

      final cachedData = jsonEncode(planetMapsList);
      await prefs.setString(cacheKey, cachedData);

      return planetMapsList;
    } on DioError catch (e) {
      log('Erro ao buscar dados', error: e);
      throw Exception('Erro ao buscar dados');
    }
  }
}
