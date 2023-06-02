import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PlanetPage extends StatefulWidget {
  const PlanetPage({Key? key}) : super(key: key);

  @override
  State<PlanetPage> createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  late PlanetBloc _planetBloc;
  late FavoritesBloc _favoritesBloc;
  List<bool> isFavoriteList = [];
  List<Planet> planets = [];

  @override
  void initState() {
    super.initState();
    _planetBloc = GetIt.I.get<PlanetBloc>();
    _planetBloc.add(OnLoadPlanet());

    _favoritesBloc = GetIt.I.get<FavoritesBloc>();
    _favoritesBloc.add(OnLoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStar(
        title: 'Planetas',
      ),
      body: BlocBuilder<PlanetBloc, PlanetState>(
        bloc: _planetBloc,
        builder: (context, state) {
          if (state is PlanetSuccessState) {
            planets = state.planet;
            return BlocBuilder<FavoritesBloc, FavoritesState>(
              bloc: _favoritesBloc,
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
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) =>
                            //       PlanetDetailScreen(planet: planet),
                            // ));
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
                                      _favoritesBloc.add(
                                        OnRemoveFavorite(
                                          favorite: favoritePlanet,
                                        ),
                                      );
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
                                      _favoritesBloc.add(
                                        OnAddFavorite(
                                          favorite: favoritePlanet,
                                        ),
                                      );
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
          } else if (state is PlanetErrorState) {
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
