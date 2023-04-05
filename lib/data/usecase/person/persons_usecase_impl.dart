import 'package:desafio_starwars_flutter/data/repository/person/person_repository.dart';
import 'package:desafio_starwars_flutter/domain/models/person_model.dart';

import './persons_usecase.dart';

class PersonsUsecaseImpl implements PersonsUsecase {
  final PersonRepository personRepository;

  PersonsUsecaseImpl({required this.personRepository});

  @override
  Future<List<Person>> getPersons() {
    return personRepository.getPersons();
  }
}
