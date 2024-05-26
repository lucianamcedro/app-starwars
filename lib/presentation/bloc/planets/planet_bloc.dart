import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;

part 'planet_state.dart';

class PlanetCubit extends bloc.Cubit<PlanetState> {
  final PlanetUsecase planetUsecase;

  PlanetCubit({required this.planetUsecase}) : super(PlanetInitialState());

  Future<void> loadPlanet() async {
    emit(PlanetLoadingState());
    try {
      final planet = await planetUsecase.getPlanets();
      emit(PlanetSuccessState(planet: planet));
    } on DioError catch (error) {
      emit(PlanetErrorState(error: error.message!));
    }
  }
}
