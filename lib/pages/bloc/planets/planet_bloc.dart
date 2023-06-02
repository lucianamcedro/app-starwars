import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'planet_event.dart';
part 'planet_state.dart';

class PlanetBloc extends Bloc<PlanetEvent, PlanetState> {
  final PlanetUsecase planetUsecase;

  PlanetBloc({required this.planetUsecase}) : super(PlanetInitialState()) {
    on<PlanetEvent>((event, emit) async {
      if (event is OnLoadPlanet) {
        try {
          final planet = await planetUsecase.getPlanets();

          emit(PlanetSuccessState(planet: planet));
        } on DioError catch (error) {
          emit(PlanetErrorState(error: error.message!));
        }
      }
    });
  }
}
