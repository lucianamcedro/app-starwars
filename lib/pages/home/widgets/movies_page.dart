import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late MoviesCubit _moviesBloc;
  late FavoritesCubit favoritesCubit;
  List<bool> isFavoriteList = [];
  List<Movies> movies = [];

  @override
  void initState() {
    super.initState();
    _moviesBloc = GetIt.I.get<MoviesCubit>();
    _moviesBloc.loadMovies();

    favoritesCubit = GetIt.I.get<FavoritesCubit>();
    favoritesCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStar(
        title: 'Filmes',
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        bloc: _moviesBloc,
        builder: (context, state) {
          if (state is MoviesSuccessState) {
            movies = state.movies;
            return BlocBuilder<FavoritesCubit, FavoritesState>(
              bloc: favoritesCubit,
              builder: (context, favoritesState) {
                if (favoritesState is FavoritesSuccessState) {
                  final favorites = favoritesState.favorite;
                  isFavoriteList = List<bool>.filled(movies.length, false);
                  for (var i = 0; i < movies.length; i++) {
                    final movie = movies[i];
                    isFavoriteList[i] = favorites
                        .any((favorite) => favorite.name == movie.title);
                  }
                }

                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    final isFavorite = isFavoriteList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) =>
                            //       MovieDetailScreen(movie: movie),
                            // ));
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(movie.title),
                                IconButton(
                                  onPressed: () {
                                    final favoriteMovie = Favorites(
                                      category: 'Movies',
                                      name: movie.title,
                                    );
                                    if (isFavorite) {
                                      favoritesCubit.removeFavorite(
                                        favoriteMovie,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Filme removido dos favoritos.',
                                          ),
                                        ),
                                      );
                                    } else {
                                      favoritesCubit.addFavorite(
                                        favoriteMovie,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Filme adicionado aos favoritos.',
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
                            subtitle: Text(movie.producer),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is MoviesErrorState) {
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
