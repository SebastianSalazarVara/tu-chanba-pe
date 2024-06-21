import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CategoryListItem.dart';
import 'province_page.dart';

class DepartmentPage extends StatelessWidget {
  final String departmentName;

  const DepartmentPage({Key? key, required this.departmentName}) : super(key: key);

  void _saveDepartment() {
    // Implementa la lógica de guardar el departamento en la base de datos
    // Por ejemplo: saveDepartmentToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: departmentName,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(
              name: '',
              entity: 'Provincia',
              isNew: true,
              onSave: _saveDepartment,  // Añadido
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CategoryListItem(
            name: 'Provincia de Ejemplo',
            imagePath: null,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailsDialog(
                  name: 'Provincia de Ejemplo',
                  entity: 'Provincia',
                  onSave: _saveDepartment,  // Añadido
                ),
              );
            },
            onMorePressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProvincePage(provinceName: 'Provincia de Ejemplo'),
                ),
              );
            },
          ),
          // Añade más provincias según sea necesario
        ],
      ),
    );
  }
}