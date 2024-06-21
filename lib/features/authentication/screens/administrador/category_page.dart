import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailDialogCategory.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CategoryListItem.dart';
import 'subcategory_page.dart';

class CategoryPage extends StatelessWidget {
  void _saveCategory() {
    // Implementa la lógica de guardar la categoría en la base de datos
    // Por ejemplo: saveCategoryToDatabase();
  }

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
              title: 'Añadir Categoría',
              name: '',
              image: 'assets/images/default.png',
              onDelete: () {
                // Implementa la lógica para eliminar la categoría
                print("Ingreso a eliminar");
                Navigator.pop(context); // Cierra el diálogo después de eliminar
              },
              onSave: _saveCategory,  // Añadido
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CategoryListItem(
            name: 'Mecánico',
            imagePath: 'assets/images/mecanico.png',
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
                  onSave: _saveCategory,  // Añadido
                ),
              );
            },
            onMorePressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubcategoryPage(categoryName: 'Mecánico'),
                ),
              );
            },
          ),
          // Añade más categorías según sea necesario
        ],
      ),
    );
  }
}


