import 'dart:convert';
import 'dart:developer';

import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonRepositoryImpl implements PersonRepository {
  static const String cacheKey = 'person_cache';

  @override
  Future<List<PersonModel>> getPersons() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      final personMapsList = jsonDecode(cachedData)
          .map<PersonModel>((e) => PersonModel.fromMap(e))
          .toList();
      return personMapsList;
    } else {
      try {
        List<PersonModel> allPersons = [];

        for (int i = 1; i <= 82; i++) {
          try {
            final response = await Dio().get('${ApiConsts.baseUrlPerson}/$i');
            final data = response.data;

            final person = PersonModel.fromMap(data);
            allPersons.add(person);
          } catch (e) {
            log('Erro ao buscar dados do personagem $i', error: e);
          }
        }

        final cachedData = jsonEncode(allPersons);
        await prefs.setString(cacheKey, cachedData);

        return allPersons;
      } on DioException catch (e) {
        log('Erro ao buscar dados', error: e);
        throw Exception('Erro ao buscar dados');
      }
    }
  }
}
