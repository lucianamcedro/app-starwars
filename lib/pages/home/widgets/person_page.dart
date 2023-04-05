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

  @override
  void initState() {
    super.initState();
    _personBloc = GetIt.I.get<PersonBloc>();
    _personBloc.add(OnLoadPerson());
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
      body: BlocBuilder<PersonBloc, PersonState>(
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
                        title: Text(
                          person.name,
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
    );
  }
}
