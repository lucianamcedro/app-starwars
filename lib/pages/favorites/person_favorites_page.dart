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
        title: const Text('Favoritos'),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
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
                final person = favorites[index];

                return ListTile(
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          favoritesBloc.add(
                            OnRemoveFavorite(favorite: person),
                          );
                        },
                        icon: Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text(person.name),
                    ],
                  ),
                  subtitle: Text(person.name),
                );
              },
            );
          } else if (state is PersonErrorState) {
            return Center(
              child: Text('Erro ao carregar os personagens favoritos.'),
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
