import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailDialogCategory.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CategoryListItem.dart';

class SubcategoryPage extends StatelessWidget {
  final String categoryName;

  const SubcategoryPage({Key? key, required this.categoryName}) : super(key: key);

  void _saveSubcategory() {
    // Implementa la lógica de guardar la subcategoría en la base de datos
    // Por ejemplo: saveSubcategoryToDatabase();
  }

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
              onSave: _saveSubcategory,  // Añadido
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CategoryListItem(
            name: 'Subcategoría 1',
            imagePath: 'assets/images/default.png',
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
                  onSave: _saveSubcategory,  // Añadido
                ),
              );
            },
            onMorePressed: () {
              // Implementa la lógica para el botón de más opciones
            },
          ),
          // Añade más subcategorías según sea necesario
        ],
      ),
    );
  }
}