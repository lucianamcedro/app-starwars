import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  final PersonsUsecase personsUsecase;

  PersonCubit({required this.personsUsecase}) : super(PersonInitialState());

  Future<void> loadPerson() async {
    emit(PersonLoadingState());
    try {
      final person = await personsUsecase.getPersons();
      emit(PersonSuccessState(person: person));
    } on DioException catch (error) {
      emit(PersonErrorState(error: error.message!));
    }
  }
}
