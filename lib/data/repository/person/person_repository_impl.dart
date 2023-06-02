import 'dart:convert';
import 'dart:developer';

import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonRepositoryImpl implements PersonRepository {
  static const String cacheKey = 'person_cache';

  @override
  Future<List<Person>> getPersons() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      final personMapsList =
          jsonDecode(cachedData).map<Person>((e) => Person.fromMap(e)).toList();
      return personMapsList;
    } else {
      try {
        dynamic result;
        result = await Dio().get(ApiConsts.baseUrlPerson);
        final dados = result.data['results'] as List;
        final personMapsList = dados.map((e) => Person.fromMap(e)).toList();

        final cachedData = jsonEncode(personMapsList);
        await prefs.setString(cacheKey, cachedData);

        return personMapsList;
      } on DioError catch (e) {
        log('Erro ao buscar dados', error: e);
        throw Exception('Erro ao buscar dados');
      }
    }
  }
}
