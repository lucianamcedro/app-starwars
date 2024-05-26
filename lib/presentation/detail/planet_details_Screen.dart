import 'package:desafio_starwars_flutter/domain/domain.dart';
import 'package:flutter/material.dart';

class PlanetDetailsScreen extends StatelessWidget {
  final Planet planet;
  const PlanetDetailsScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
