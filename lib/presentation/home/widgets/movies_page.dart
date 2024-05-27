import 'package:desafio_starwars_flutter/presentation/detail/movie_details_screen.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late MoviesCubit _moviesBloc;
  late FavoritesCubit favoritesCubit;
  List<bool> isFavoriteList = [];
  List<MoviesModel> movies = [];

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
      backgroundColor: ColorsScheme.black,
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
                    isFavoriteList[i] = favorites.any(
                      (favorite) => favorite.name == movie.title,
                    );
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
                        color: ColorsScheme.greyDark,
                        elevation: 6,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsScreen(moviesModel: movie),
                            ));
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/movies.svg',
                                        width: 50,
                                        height: 50,
                                      ),
                                      SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nome: ${movie.title}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Data: ${DateFormat('dd/MM/yyyy').format(movie.releaseDate)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final favoriteMovie = Favorites(
                                      category: 'Filmes',
                                      name: movie.title,
                                    );
                                    if (isFavorite) {
                                      favoritesCubit
                                          .removeFavorite(favoriteMovie);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Filme removido dos favoritos.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      favoritesCubit.addFavorite(favoriteMovie);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Filme adicionado aos favoritos.'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: isFavorite
                                        ? Colors.amber
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          if (state is MoviesErrorState) {
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
