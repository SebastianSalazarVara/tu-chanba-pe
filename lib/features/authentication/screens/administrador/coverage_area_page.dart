import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CategoryListItem.dart';
import 'department_page.dart';

class CoverageAreaPage extends StatelessWidget {
  void _saveCoverageArea() {
    // Implementa la lógica de guardar el área de cobertura en la base de datos
    // Por ejemplo: saveCoverageAreaToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Área de Cobertura',
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(
              name: '',
              entity: 'Departamento',
              isNew: true,
              onSave: _saveCoverageArea,  // Añadido
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CategoryListItem(
            name: 'Departamento de Ejemplo',
            imagePath: null,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailsDialog(
                  name: 'Departamento de Ejemplo',
                  entity: 'Departamento',
                  onSave: _saveCoverageArea,  // Añadido
                ),
              );
            },
            onMorePressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartmentPage(departmentName: 'Departamento de Ejemplo'),
                ),
              );
            },
          ),
          // Añade más áreas de cobertura según sea necesario
        ],
      ),
    );
  }
}