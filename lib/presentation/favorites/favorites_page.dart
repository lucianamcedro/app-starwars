import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class FavoritesPage extends StatefulWidget {
  final String name;

  const FavoritesPage({super.key, required this.name});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesCubit favoritesCubit;
  List<Favorites> moviesFavorites = [];
  List<Favorites> planetsFavorites = [];
  List<Favorites> charactersFavorites = [];

  @override
  void initState() {
    super.initState();
    favoritesCubit = GetIt.I.get<FavoritesCubit>()..loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStar(
        title: 'Meus Favoritos',
      ),
      body: Builder(
        builder: (context) {
          return BlocBuilder<FavoritesCubit, FavoritesState>(
            bloc: favoritesCubit,
            builder: (context, state) {
              if (state is FavoritesSuccessState) {
                final favorites = state.favorite;

                moviesFavorites = favorites
                    .where((favorite) => favorite.category == 'Filmes')
                    .toList();
                planetsFavorites = favorites
                    .where((favorite) => favorite.category == 'Planetas')
                    .toList();
                charactersFavorites = favorites
                    .where((favorite) => favorite.category == 'Personagens')
                    .toList();

                if (moviesFavorites.isEmpty &&
                    planetsFavorites.isEmpty &&
                    charactersFavorites.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum favorito à ser exibido.',
                      style: TextStyle(
                        color: ColorsScheme.black,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      if (moviesFavorites.isNotEmpty) ...[
                        _buildCategoryList('Filmes', moviesFavorites),
                      ],
                      if (planetsFavorites.isNotEmpty) ...[
                        _buildCategoryList('Planetas', planetsFavorites),
                      ],
                      if (charactersFavorites.isNotEmpty) ...[
                        _buildCategoryList('Personagens', charactersFavorites),
                      ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
            physics: NeverScrollableScrollPhysics(),
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
                        favoritesCubit.removeFavorite(favoriteItem);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Removido dos favoritos'),
                            backgroundColor: Colors.red,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
