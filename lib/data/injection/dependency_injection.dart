import 'package:desafio_starwars_flutter/starwars.dart';
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

    getIt.registerFactory<FavoritesRepository>(
      () => PersonFavoritesRepositoryImpl(),
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

    getIt.registerLazySingleton<FavoritesUsecase>(
      () => FavoritesUsecaseImpl(
        favoritesRepository: getIt<FavoritesRepository>(),
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

    getIt.registerFactory<FavoritesBloc>(
      () => FavoritesBloc(
        favoritesUsecase: getIt<FavoritesUsecase>(),
      ),
    );
  }
}
