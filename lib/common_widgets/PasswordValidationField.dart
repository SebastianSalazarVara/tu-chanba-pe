// lib/common_widgets/password_validation_field.dart

import 'package:flutter/material.dart';

class PasswordValidationField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const PasswordValidationField({
    Key? key,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _PasswordValidationFieldState createState() => _PasswordValidationFieldState();
}

class _PasswordValidationFieldState extends State<PasswordValidationField> {
  bool _isPasswordVisible = false;
  bool _isLengthValid = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  void _validatePassword(String password) {
    setState(() {
      _isLengthValid = password.length >= 8;
      _hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
    if (widget.onChanged != null) widget.onChanged!(password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          obscureText: !_isPasswordVisible,
          onChanged: _validatePassword,
        ),
        SizedBox(height: 5),
        _buildPasswordCriteriaRow('Mínimo 8 caracteres', _isLengthValid),
        _buildPasswordCriteriaRow('Uso de mayúsculas', _hasUpperCase),
        _buildPasswordCriteriaRow('Uso de números', _hasNumber),
        _buildPasswordCriteriaRow('Uso de símbolos', _hasSpecialChar),
      ],
    );
  }

  Widget _buildPasswordCriteriaRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle_outline : Icons.highlight_off,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
