import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late PersonCubit _personBloc;
  late FavoritesCubit _favoritesCubit;
  List<bool> _isFavoriteList = [];
  List<Person> _people = [];

  @override
  void initState() {
    super.initState();
    _personBloc = GetIt.I.get<PersonCubit>();
    _personBloc.loadPerson();

    _favoritesCubit = GetIt.I.get<FavoritesCubit>();
    _favoritesCubit.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStar(
        title: 'Personagens',
      ),
      body: BlocBuilder<PersonCubit, PersonState>(
        bloc: _personBloc,
        builder: (context, state) {
          if (state is PersonSuccessState) {
            _people = state.person;
            return BlocBuilder<FavoritesCubit, FavoritesState>(
              bloc: _favoritesCubit,
              builder: (context, favoritesState) {
                if (favoritesState is FavoritesSuccessState) {
                  final favorites = favoritesState.favorite;
                  _isFavoriteList = List<bool>.filled(_people.length, false);
                  for (var i = 0; i < _people.length; i++) {
                    final person = _people[i];
                    _isFavoriteList[i] = favorites
                        .any((favorite) => favorite.name == person.name);
                  }
                }

                return ListView.builder(
                  itemCount: _people.length,
                  itemBuilder: (context, index) {
                    final person = _people[index];
                    final isFavorite = _isFavoriteList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PersonDetailScreen(person: person),
                            ));
                          },
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(person.name),
                                IconButton(
                                  onPressed: () {
                                    final favoritePerson = Favorites(
                                      name: person.name,
                                      category: 'Personagens',
                                    );
                                    if (isFavorite) {
                                      _favoritesCubit.removeFavorite(
                                        favoritePerson,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Personagem removido dos favoritos.',
                                          ),
                                        ),
                                      );
                                    } else {
                                      _favoritesCubit.addFavorite(
                                        favoritePerson,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Personagem adicionado aos favoritos.',
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
                            subtitle: Text(person.birthYear),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is PersonErrorState) {
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
