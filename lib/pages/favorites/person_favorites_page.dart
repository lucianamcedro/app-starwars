import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PersonFavoritesPage extends StatefulWidget {
  final String name;
  const PersonFavoritesPage({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<PersonFavoritesPage> createState() => _PersonFavoritesPageState();
}

class _PersonFavoritesPageState extends State<PersonFavoritesPage> {
  late PersonFavoritesBloc personFavoritesBloc;

  @override
  void initState() {
    super.initState();
    personFavoritesBloc = GetIt.I.get<PersonFavoritesBloc>();
    personFavoritesBloc.add(OnLoadPersonFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens Favoritos'),
      ),
      body: BlocBuilder<PersonFavoritesBloc, PersonFavoritesState>(
        bloc: personFavoritesBloc,
        builder: (context, state) {
          if (state is PersonFavoritesSuccessState) {
            final favorites = state.personagem;

            if (favorites.isEmpty) {
              return Center(
                child: Text('Nenhum personagem favorito.'),
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
                          personFavoritesBloc.add(
                            OnRemovePersonFavorite(personFavorite: person),
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
          } else if (state is PersonFavoritesErrorState) {
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
