import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';
import 'department_page.dart';

class CoverageAreaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Área de Cobertura',
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(name: '', entity: 'Departamento', isNew: true),
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
                builder: (context) => DetailsDialog(name: 'Departamento de Ejemplo', entity: 'Departamento'),
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
                  Expanded(
                    child: Text(
                      'Departamento de Ejemplo',
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
                          builder: (context) => DepartmentPage(departmentName: 'Departamento de Ejemplo'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Añade más áreas de cobertura según sea necesario
        ],
      ),
    );
  }
}
