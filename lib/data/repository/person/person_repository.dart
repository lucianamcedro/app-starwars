import 'package:desafio_starwars_flutter/starwars.dart';

abstract class PersonRepository {
  Future<List<PersonModel>> getPersons();
}
