import 'package:desafio_starwars_flutter/pages/pages.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            width: size.width,
            height: size.height,
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black45),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 100,
                ),
                Flexible(
                  child: Container(
                    height: 56.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Flexible(
                  child: Container(
                    height: 56.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonsLogin(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
