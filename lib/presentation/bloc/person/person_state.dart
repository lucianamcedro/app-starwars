part of 'person_bloc.dart';

abstract class PersonState {}

class PersonInitialState extends PersonState {}

class PersonLoadingState extends PersonState {}

class PersonSuccessState extends PersonState {
  final List<Person> person;

  PersonSuccessState({required this.person});
}

class PersonErrorState extends PersonState {
  final String error;

  PersonErrorState({required this.error});
}
