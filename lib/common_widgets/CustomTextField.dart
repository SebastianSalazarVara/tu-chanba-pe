import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxLines;  // Añadir este parámetro

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,  // Añadir este parámetro con un valor por defecto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      maxLines: maxLines,  // Añadir este parámetro al TextFormField
    );
  }
}
