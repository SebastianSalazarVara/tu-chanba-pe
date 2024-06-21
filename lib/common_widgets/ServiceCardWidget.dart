import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'CommentWidget.dart';
import 'ServiceDetailWidget.dart'; // Importa ServiceDetailWidget

class ServiceCardWidget extends StatelessWidget {
  final String serviceImagePath;
  final String category;
  final int rating;
  final String serviceName;
  final int price;
  final String providerImagePath;
  final String providerName;
  final List<Comment> comments; // Define lista de comentarios
  final VoidCallback onEdit; // Callback para editar
  final VoidCallback onDelete; // Callback para eliminar

  ServiceCardWidget({
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
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ServiceDetailWidget(
            serviceImagePath: serviceImagePath,
            category: category,
            rating: rating,
            serviceName: serviceName,
            price: price,
            providerImagePath: providerImagePath,
            providerName: providerName,
            comments: comments,
            onEdit: onEdit, // Pasa el callback de editar
            onDelete: onDelete, // Pasa el callback de eliminar
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(serviceImagePath, fit: BoxFit.cover, height: 150, width: double.infinity),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'S/ $price por 1:00 hr',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
