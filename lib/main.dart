import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  DependencyInjection.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
