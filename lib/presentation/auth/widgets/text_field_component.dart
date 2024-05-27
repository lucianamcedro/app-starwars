import 'package:desafio_starwars_flutter/domain/domain.dart';
import 'package:desafio_starwars_flutter/starwars.dart';
import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;

  const TextFieldComponent({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.focusNode,
    this.textInputType,
    this.initialValue,
    this.onFieldSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: ColorsScheme.grey,
        ),
        isCollapsed: false,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: ColorsScheme.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorsScheme.red,
          ),
        ),
        isDense: false,
      ),
    );
  }
}
