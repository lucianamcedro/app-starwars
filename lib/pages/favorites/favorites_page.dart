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

  @override
  void initState() {
    super.initState();
    favoritesBloc = GetIt.I.get<FavoritesBloc>();
    favoritesBloc.add(OnLoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Favoritos',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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

                  return ListView.builder(
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
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Removido dos favoritos',
                                    ),
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
                        subtitle: Text(favoriteItem.name),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ));
  }
}
