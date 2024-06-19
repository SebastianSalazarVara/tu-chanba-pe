import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailDialogCategory.dart';
import '../../../../common_widgets/TopBar.dart';
import 'subcategory_page.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Categorías',
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailDialogCategory(
              title: 'Editar Categoría',
              name: '',
              image: 'assets/images/default.png',
              onDelete: () {
                // Implementa la lógica para eliminar la categoría
                Navigator.pop(context); // Cierra el diálogo después de eliminar
              },
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailDialogCategory(
                  title: 'Editar Categoría',
                  name: 'Mecánico',
                  image: 'assets/images/mecanico.png',
                  onDelete: () {
                    // Implementa la lógica para eliminar la categoría
                    Navigator.pop(context); // Cierra el diálogo después de eliminar
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/mecanico.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Mecánico',
                      style: TextStyle(
                        fontFamily: 'Mont-Bold',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubcategoryPage(categoryName: 'Mecánico'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Añade más categorías según sea necesario
        ],
      ),
    );
  }
}


