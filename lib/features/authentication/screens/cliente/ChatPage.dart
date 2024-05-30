import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final Map<String, String> chat;

  ChatPage({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(chat['name']!),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(chat['profilePic']!),
                  ),
                  title: Text(chat['name']!),
                  subtitle: Text(chat['lastMessage']!),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    // Implementar lógica para subir imágenes
                  },
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    // Implementar lógica para subir documentos
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Escribe un mensaje...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Implementar lógica para enviar mensajes
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
