import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 2)).then((_) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage())));
    return Scaffold(
        body: Stack(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/splash.jpeg',
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ],
    ));
  }
}
