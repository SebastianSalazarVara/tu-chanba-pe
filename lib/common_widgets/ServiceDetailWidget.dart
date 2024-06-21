import 'package:flutter/material.dart';
import 'package:tuchanbape/common_widgets/CommentWidget.dart';

class ServiceDetailWidget extends StatelessWidget {
  final String serviceImagePath;
  final String category;
  final int rating;
  final String serviceName;
  final int price;
  final String providerImagePath;
  final String providerName;
  final List<Comment> comments;
  final VoidCallback onEdit; // Callback para editar
  final VoidCallback onDelete; // Callback para eliminar

  ServiceDetailWidget({
    required this.serviceImagePath,
    required this.category,
    required this.rating,
    required this.serviceName,
    required this.price,
    required this.providerImagePath,
    required this.providerName,
    required this.comments,
    required this.onEdit, // Inicializa callback de editar
    required this.onDelete, // Inicializa callback de eliminar
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  serviceImagePath,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            onEdit(); // Llama al callback de editar
                          } else if (value == 'delete') {
                            onDelete(); // Llama al callback de eliminar
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Editar', 'Eliminar'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice.toLowerCase(),
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 16,
                          );
                        }),
                      ),
                      SizedBox(height: 8),
                      Text(
                        serviceName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'S/ $price por 1:00 hr',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(providerImagePath),
                            radius: 20,
                          ),
                          SizedBox(width: 8),
                          Text(providerName),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Descripción del servicio...',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Distritos disponibles:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Distritos disponibles 1\nDistritos disponibles 2\nDistritos disponibles 3',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Reseñas:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: comments.map((comment) => CommentWidget(comment: comment)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
