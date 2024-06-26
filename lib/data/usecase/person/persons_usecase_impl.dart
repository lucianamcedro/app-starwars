import 'package:desafio_starwars_flutter/starwars.dart';

class PersonsUsecaseImpl implements PersonsUsecase {
  final PersonRepository personRepository;

  PersonsUsecaseImpl({required this.personRepository});

  @override
  Future<List<PersonModel>> getPersons() {
    return personRepository.getPersons();
  }
}
