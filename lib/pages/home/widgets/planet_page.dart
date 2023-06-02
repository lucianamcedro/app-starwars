import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PlanetPage extends StatefulWidget {
  const PlanetPage({Key? key}) : super(key: key);

  @override
  State<PlanetPage> createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  late PlanetBloc _planetBloc;

  @override
  void initState() {
    super.initState();
    _planetBloc = GetIt.I.get<PlanetBloc>();
    _planetBloc.add(OnLoadPlanet());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Planetas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<PlanetBloc, PlanetState>(
        bloc: _planetBloc,
        builder: (context, state) {
          if (state is PlanetSuccessState) {
            final planets = state.planet;
            return ListView.builder(
              itemCount: planets.length,
              itemBuilder: (context, index) {
                final planet = planets[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Card(
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) =>
                        //       PlanetDetailScreen(movie: movie),
                        // ));
                      },
                      child: ListTile(
                        title: Text(
                          planet.name,
                        ),
                        subtitle: Text(planet.population),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PlanetErrorState) {
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
