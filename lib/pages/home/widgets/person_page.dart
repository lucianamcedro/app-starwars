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
  bool isFavorite = false;

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
            if (state is PersonFavoritesSuccessState) {}

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
                final people = state.person;
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
                                Text(
                                  person.name,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star,
                                    color: isFavorite ? Colors.amber : null,
                                  ),
                                )
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
