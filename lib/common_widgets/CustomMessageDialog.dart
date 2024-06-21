import 'package:flutter/material.dart';

class CustomMessageDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onConfirm;
  final bool hideButtons;

  const CustomMessageDialog({
    Key? key,
    required this.message,
    this.onConfirm,
    this.hideButtons = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          message,
          style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      content: hideButtons
          ? SizedBox.shrink()
          : Row(
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
              if (onConfirm != null) onConfirm!(); // Ejecutar la función de confirmación
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
