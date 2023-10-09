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
    getIt.registerFactory<PersonCubit>(
      () => PersonCubit(
        personsUsecase: getIt<PersonsUsecase>(),
      ),
    );
    getIt.registerFactory<MoviesCubit>(
      () => MoviesCubit(
        moviesUsecase: getIt<MoviesUsecase>(),
      ),
    );
    getIt.registerFactory<PlanetCubit>(
      () => PlanetCubit(
        planetUsecase: getIt<PlanetUsecase>(),
      ),
    );

    getIt.registerFactory<FavoritesCubit>(
      () => FavoritesCubit(
        favoritesUsecase: getIt<FavoritesUsecase>(),
      ),
    );
  }
}
