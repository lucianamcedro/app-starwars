import 'package:desafio_starwars_flutter/starwars.dart';

abstract class PersonsUsecase {
  Future<List<Person>> getPersons();
}
