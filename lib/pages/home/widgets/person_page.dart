import 'package:desafio_starwars_flutter/domain/models/person_favorites_model.dart';
import 'package:desafio_starwars_flutter/domain/models/person_model.dart';
import 'package:desafio_starwars_flutter/pages/bloc/bloc.dart';
import 'package:desafio_starwars_flutter/pages/detail/person_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late PersonBloc _personBloc;
  late PersonFavoritesBloc personFavoritesBloc;
  List<bool> isFavoriteList = [];
  List<Person> people = [];

  @override
  void initState() {
    super.initState();
    _personBloc = GetIt.I.get<PersonBloc>();
    _personBloc.add(OnLoadPerson());

    personFavoritesBloc = GetIt.I.get<PersonFavoritesBloc>();
    personFavoritesBloc.add(OnLoadPersonFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Personagens',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocProvider<PersonFavoritesBloc>(
        create: (context) => personFavoritesBloc,
        child: BlocListener<PersonFavoritesBloc, PersonFavoritesState>(
          listener: (context, state) {
            if (state is PersonFavoritesSuccessState) {
              final favorites = state.personagem;
              isFavoriteList = List<bool>.filled(people.length, false);
              for (var i = 0; i < people.length; i++) {
                final person = people[i];
                isFavoriteList[i] =
                    favorites.any((favorite) => favorite.name == person.name);
              }
              setState(() {});
            }

            if (state is OnAddPersonFavorite) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Personagem adicionado aos favoritos.')),
              );
            } else if (state is OnRemovePersonFavorite) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Personagem removido dos favoritos.')),
              );
            }
          },
          child: BlocBuilder<PersonBloc, PersonState>(
            bloc: _personBloc,
            builder: (context, state) {
              if (state is PersonSuccessState) {
                people = state.person;
                isFavoriteList = List<bool>.filled(people.length, false);
                return ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    final person = people[index];

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
                                  onPressed: () async {
                                    final favoritePerson =
                                        PersonFavorites(name: person.name);
                                    if (isFavoriteList[index]) {
                                      personFavoritesBloc.add(
                                        OnRemovePersonFavorite(
                                          personFavorite: favoritePerson,
                                        ),
                                      );
                                    } else {
                                      personFavoritesBloc.add(
                                        OnAddPersonFavorite(
                                          personFavorite: favoritePerson,
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.star,
                                    color: isFavoriteList[index]
                                        ? Colors.amber
                                        : Colors.grey,
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
        ),
      ),
    );
  }
}
