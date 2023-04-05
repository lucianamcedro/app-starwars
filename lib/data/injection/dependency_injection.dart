import 'package:desafio_starwars_flutter/data/repository/repository.dart';
import 'package:desafio_starwars_flutter/data/usecase/usecase.dart';
import 'package:desafio_starwars_flutter/pages/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static initialize() {
    final GetIt getIt = GetIt.instance;

    // REPOSITORY
    getIt.registerFactory<PersonRepository>(
      () => PersonRepositoryImpl(),
    );

    getIt.registerFactory<PlanetRepository>(
      () => PlanetRepositoryImpl(),
    );

    getIt.registerFactory<MoviesRepository>(
      () => MoviesRepositoryImpl(),
    );

    // USE CASE
    getIt.registerLazySingleton<PersonsUsecase>(
      () => PersonsUsecaseImpl(
        personRepository: getIt<PersonRepository>(),
      ),
    );

    getIt.registerLazySingleton<PlanetUsecase>(
      () => PlanetUsecaseImpl(
        planetRepository: getIt<PlanetRepository>(),
      ),
    );

    getIt.registerLazySingleton<MoviesUsecase>(
      () => MoviesUsecaseImpl(
        moviesRepository: getIt<MoviesRepository>(),
      ),
    );

    // BLOC
    getIt.registerFactory<PersonBloc>(
      () => PersonBloc(
        personsUsecase: getIt<PersonsUsecase>(),
      ),
    );
    getIt.registerFactory<MoviesBloc>(
      () => MoviesBloc(
        moviesUsecase: getIt<MoviesUsecase>(),
      ),
    );
    getIt.registerFactory<PlanetBloc>(
      () => PlanetBloc(
        planetUsecase: getIt<PlanetUsecase>(),
      ),
    );
  }
}
