import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FavoritesPage extends StatefulWidget {
  final String name;

  const FavoritesPage({
    super.key,
    required this.name,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesBloc favoritesBloc;
  List<Favorites> moviesFavorites = [];
  List<Favorites> planetsFavorites = [];
  List<Favorites> charactersFavorites = [];

  @override
  void initState() {
    super.initState();
    favoritesBloc = GetIt.I.get<FavoritesBloc>();
    favoritesBloc.add(OnLoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStar(
        title: 'Favorites',
      ),
      body: Builder(
        builder: (context) {
          return BlocBuilder<FavoritesBloc, FavoritesState>(
            bloc: favoritesBloc,
            builder: (context, state) {
              if (state is FavoritesSuccessState) {
                final favorites = state.favorite;

                if (favorites.isEmpty) {
                  return Center(
                    child: Text('Nenhum favorito.'),
                  );
                }

                moviesFavorites = favorites
                    .where((favorite) => favorite.category == 'Movies')
                    .toList();
                planetsFavorites = favorites
                    .where((favorite) => favorite.category == 'Planetas')
                    .toList();
                charactersFavorites = favorites
                    .where((favorite) => favorite.category == 'Personagens')
                    .toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      if (moviesFavorites.isNotEmpty)
                        _buildCategoryList('Filmes', moviesFavorites),
                      if (planetsFavorites.isNotEmpty)
                        _buildCategoryList('Planetas', planetsFavorites),
                      if (charactersFavorites.isNotEmpty)
                        _buildCategoryList('Personagens', charactersFavorites),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildCategoryList(String categoryTitle, List<Favorites> favorites) {
    return Column(
      children: [
        Text(
          categoryTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final favoriteItem = favorites[index];
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(favoriteItem.name),
                  IconButton(
                    onPressed: () {
                      favoritesBloc.add(
                        OnRemoveFavorite(favorite: favoriteItem),
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removido dos favoritos'),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              subtitle: Text(favoriteItem.category),
            );
          },
        ),
      ],
    );
  }
}
