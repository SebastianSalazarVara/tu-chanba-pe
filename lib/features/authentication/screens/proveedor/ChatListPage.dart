import 'package:flutter/material.dart';

import 'ChatPage.dart';

class ChatListPage extends StatelessWidget {
  final List<Map<String, String>> chats = [
    {
      "name": "Mateo Romero",
      "lastMessage": "Hola",
      "date": "9 de Abril, 2024",
      "profilePic": "assets/images/mateo.jpg"
    },
    // Agrega más chats aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text("Chat"),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chat['profilePic']!),
            ),
            title: Text(chat['name']!),
            subtitle: Text(chat['lastMessage']!),
            trailing: Text(chat['date']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage(chat: chat)),
              );
            },
          );
        },
      ),
    );
  }
}
