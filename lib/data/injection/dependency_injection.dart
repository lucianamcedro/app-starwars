import 'package:desafio_starwars_flutter/data/usecase/auth/auth.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  static initialize() {
    final GetIt getIt = GetIt.instance;

    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

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

    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(),
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

    getIt.registerLazySingleton<AuthUsecase>(
      () => AuthUsecaseImp(
        authRepository: getIt<AuthRepository>(),
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
    getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        authUsecase: getIt<AuthUsecase>(),
      ),
    );
    getIt.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(auth: FirebaseAuth.instance),
    );
  }
}
