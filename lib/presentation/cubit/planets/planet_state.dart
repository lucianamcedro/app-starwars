part of 'planet_cubit.dart';

abstract class PlanetState {}

class PlanetInitialState extends PlanetState {}

class PlanetLoadingState extends PlanetState {}

class PlanetSuccessState extends PlanetState {
  final List<PlanetModel> planet;

  PlanetSuccessState({required this.planet});
}

class PlanetErrorState extends PlanetState {
  final String error;

  PlanetErrorState({required this.error});
}
