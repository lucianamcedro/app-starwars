import 'package:desafio_starwars_flutter/presentation/detail/planet_details_Screen.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PlanetPage extends StatefulWidget {
  const PlanetPage({super.key});

  @override
  State<PlanetPage> createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  late PlanetCubit _planetBloc;
  late FavoritesCubit favoritesCubit;
  List<bool> isFavoriteList = [];
  List<Planet> planets = [];

  @override
  void initState() {
    super.initState();
    _planetBloc = GetIt.I.get<PlanetCubit>();
    _planetBloc.loadPlanet();

    favoritesCubit = GetIt.I.get<FavoritesCubit>();
    favoritesCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStar(
        title: 'Planetas',
      ),
      body: BlocBuilder<PlanetCubit, PlanetState>(
        bloc: _planetBloc,
        builder: (context, state) {
          if (state is PlanetSuccessState) {
            planets = state.planet;
            return BlocBuilder<FavoritesCubit, FavoritesState>(
              bloc: favoritesCubit,
              builder: (context, favoritesState) {
                if (favoritesState is FavoritesSuccessState) {
                  final favorites = favoritesState.favorite;
                  isFavoriteList = List<bool>.filled(planets.length, false);
                  for (var i = 0; i < planets.length; i++) {
                    final planet = planets[i];
                    isFavoriteList[i] = favorites
                        .any((favorite) => favorite.name == planet.name);
                  }
                }

                return ListView.builder(
                  itemCount: planets.length,
                  itemBuilder: (context, index) {
                    final planet = planets[index];
                    final isFavorite = isFavoriteList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PlanetDetailsScreen(planet: planet),
                            ));
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(planet.name),
                                IconButton(
                                  onPressed: () {
                                    final favoritePlanet = Favorites(
                                      name: planet.name,
                                      category: 'Planetas',
                                    );
                                    if (isFavorite) {
                                      favoritesCubit
                                          .removeFavorite(favoritePlanet);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Planeta removido dos favoritos.',
                                          ),
                                        ),
                                      );
                                    } else {
                                      favoritesCubit
                                          .addFavorite(favoritePlanet);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Planeta adicionado aos favoritos.',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color:
                                        isFavorite ? Colors.amber : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Text(planet.population),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is PlanetErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
