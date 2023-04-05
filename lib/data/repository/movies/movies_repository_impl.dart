import 'dart:developer';

import 'package:desafio_starwars_flutter/domain/models/movies_model.dart';
import 'package:desafio_starwars_flutter/domain/shared/const.dart';
import 'package:dio/dio.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  @override
  Future<List<Movies>> getMovies() async {
    try {
      dynamic result;
      result = await Dio().get(ApiConsts.baseUrlMovies);
      final dados = result.data['results'] as List;
      final moviesMapsList = dados.map((e) => Movies.fromMap(e)).toList();

      return moviesMapsList;
    } on DioError catch (e) {
      log('Erro ao buscar dados', error: e);
      throw Exception('Erro ao buscar dados');
    }
  }
}
