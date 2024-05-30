import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones', style: TextStyle(fontFamily: 'Mont-Bold')),
        backgroundColor: Color(0xFF6286CB),
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            'Mateo Romero ha reservado tu servicio. Por favor confirma el servicio',
            'Hace 1 hora',
          ),
          _buildNotificationItem(
            'Mateo Romero ha reservado tu servicio. Por favor confirma el servicio',
            'Hace 2 horas',
          ),
          _buildNotificationItem(
            'Marcos Romero ha reservado tu servicio. Por favor confirma el servicio',
            'Hace 3 horas',
          ),
          _buildNotificationItem(
            'El estado ha cambiado de aceptada a En Progreso',
            'Hace 1 día',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String message, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/user_avatar.png'), // Add your image asset
      ),
      title: Text('Armarios y vestidores a medida', style: TextStyle(fontFamily: 'Mont-Bold')),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: TextStyle(fontFamily: 'Mont-Regular')),
          Text(time, style: TextStyle(fontFamily: 'Mont-Regular', color: Colors.grey)),
        ],
      ),
      isThreeLine: true,
    );
  }
}
