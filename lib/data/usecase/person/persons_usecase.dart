import 'package:desafio_starwars_flutter/domain/models/person_model.dart';

abstract class PersonsUsecase {
  Future<List<Person>> getPersons();
}
