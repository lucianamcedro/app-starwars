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
  late MoviesBloc _moviesBloc;
  late FavoritesBloc _favoritesBloc;
  List<bool> isFavoriteList = [];
  List<Movies> movies = [];

  @override
  void initState() {
    super.initState();
    _moviesBloc = GetIt.I.get<MoviesBloc>();
    _moviesBloc.add(OnLoadMovies());

    _favoritesBloc = GetIt.I.get<FavoritesBloc>();
    _favoritesBloc.add(OnLoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Filmes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        bloc: _moviesBloc,
        builder: (context, state) {
          if (state is MoviesSuccessState) {
            movies = state.movies;
            return BlocBuilder<FavoritesBloc, FavoritesState>(
              bloc: _favoritesBloc,
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
                                      _favoritesBloc.add(
                                        OnRemoveFavorite(
                                          favorite: favoriteMovie,
                                        ),
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
                                      _favoritesBloc.add(
                                        OnAddFavorite(
                                          favorite: favoriteMovie,
                                        ),
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
