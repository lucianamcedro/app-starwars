import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  static const String cacheKey = 'movies_cache';

  @override
  Future<List<Movies>> getMovies() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      try {
        final decodedData = jsonDecode(cachedData);
        if (decodedData is List) {
          final moviesList = decodedData
              .map((e) => Movies.fromMap(Map<String, dynamic>.from(e)))
              .toList();

          return moviesList;
        }
      } catch (e) {
        log('Erro ao decodificar dados do cache', error: e);
      }
    }

    try {
      final result = await Dio().get(ApiConsts.baseUrlMovies);
      final dados = result.data['results'] as List;
      final moviesList = dados.map((e) => Movies.fromMap(e)).toList();

      final cachedData =
          jsonEncode(moviesList.map((movie) => movie.toMap()).toList());
      await prefs.setString(cacheKey, cachedData);

      return moviesList;
    } on DioError catch (e) {
      log('Erro ao buscar dados', error: e);
      throw Exception('Erro ao buscar dados');
    }
  }
}
