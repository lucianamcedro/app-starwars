import 'dart:developer';

import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';

class PersonRepositoryImpl implements PersonRepository {
  @override
  Future<List<Person>> getPersons() async {
    try {
      dynamic result;
      result = await Dio().get(ApiConsts.baseUrlPerson);
      final dados = result.data['results'] as List;
      final personMapsList = dados.map((e) => Person.fromMap(e)).toList();

      return personMapsList;
    } on DioError catch (e) {
      log('Erro ao buscar dados', error: e);
      throw Exception('Erro ao buscar dados');
    }
  }
}
