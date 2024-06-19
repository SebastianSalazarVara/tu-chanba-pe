import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailDialogCategory.dart';
import '../../../../common_widgets/TopBar.dart';

class SubcategoryPage extends StatelessWidget {
  final String categoryName;

  const SubcategoryPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: categoryName,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailDialogCategory(
              title: 'Editar Subcategoría',
              name: '',
              image: 'assets/images/default.png',
              onDelete: () {
                // Implementa la lógica para eliminar la subcategoría
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
                  title: 'Editar Subcategoría',
                  name: 'Subcategoría 1',
                  image: 'assets/images/default.png',
                  onDelete: () {
                    // Implementa la lógica para eliminar la subcategoría
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
                    backgroundImage: AssetImage('assets/images/default.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Subcategoría 1',
                      style: TextStyle(
                        fontFamily: 'Mont-Bold',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.more_vert, color: Colors.black),
                ],
              ),
            ),
          ),
          // Añade más subcategorías según sea necesario
        ],
      ),
    );
  }
}

