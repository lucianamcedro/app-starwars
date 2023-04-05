import 'package:desafio_starwars_flutter/domain/models/person_model.dart';
import 'package:flutter/material.dart';

class PersonDetailScreen extends StatelessWidget {
  final Person person;
  const PersonDetailScreen({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${person.name}'),
            Text('Birth Year: ${person.birthYear}'),
            Text('Gender: ${person.gender}'),
            // adicione mais informações aqui, se desejar
          ],
        ),
      ),
    );
  }
}
