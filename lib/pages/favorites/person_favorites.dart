import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PersonFavorites extends StatefulWidget {
  const PersonFavorites({Key? key}) : super(key: key);

  @override
  State<PersonFavorites> createState() => _PersonFavoritesState();
}

class _PersonFavoritesState extends State<PersonFavorites> {
  late PersonFavorites _personFavorites;

  @override
  void initState() {
    super.initState();
    _personFavorites = GetIt.I.get<PersonFavorites>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens Favoritos'),
      ),
      body: Container(),
    );
  }
}
