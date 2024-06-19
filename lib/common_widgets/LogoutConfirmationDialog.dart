import 'package:flutter/material.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutConfirmationDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          '¿Estás seguro/a de que deseas cerrar sesión?',
          style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: Text('Cancelar', style: TextStyle(color: Colors.black)),
            style: TextButton.styleFrom(
              side: BorderSide(color: Color(0xFF3F60A0)),
            ),
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
              onConfirm(); // Ejecutar la función de cierre de sesión
            },
            child: Text('Confirmar', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3F60A0)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

