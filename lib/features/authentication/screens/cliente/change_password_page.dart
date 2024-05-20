import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          'Cambiar Contraseña',
          style: TextStyle(
            fontFamily: 'Mont-Bold',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'Contenido de Cambiar Contraseña',
          style: TextStyle(
            fontFamily: 'Mont-Bold',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}