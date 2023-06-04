import 'package:flutter/material.dart';

class FormsPage extends StatelessWidget {
  const FormsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 1,
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
          flex: 1,
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
      ],
    );
  }
}
