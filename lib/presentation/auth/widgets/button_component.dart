import 'package:desafio_starwars_flutter/domain/domain.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;
  final Color? colorButton;

  const ButtonComponent({
    super.key,
    required this.onPressed,
    required this.textButton,
    this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 50,
      width: sizeHeight * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            colorButton ?? ColorsScheme.black,
          ),
        ),
        child: Text(
          textButton,
          style: TextStyle(
            color: ColorsScheme.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
