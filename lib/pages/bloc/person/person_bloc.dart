import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonsUsecase personsUsecase;

  PersonBloc({required this.personsUsecase}) : super(PersonInitialState()) {
    on<PersonEvent>((event, emit) async {
      if (event is OnLoadPerson) {
        try {
          final person = await personsUsecase.getPersons();

          emit(PersonSuccessState(person: person));
        } on DioError catch (error) {
          emit(PersonErrorState(error: error.message!));
        }
      }
    });
  }
}
