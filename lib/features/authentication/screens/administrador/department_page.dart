import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';
import 'province_page.dart';

class DepartmentPage extends StatelessWidget {
  final String departmentName;

  const DepartmentPage({Key? key, required this.departmentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: departmentName,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(name: '', entity: 'Provincia', isNew: true),
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
                builder: (context) => DetailsDialog(name: 'Provincia de Ejemplo', entity: 'Provincia'),
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
                      'Provincia de Ejemplo',
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
                          builder: (context) => ProvincePage(provinceName: 'Provincia de Ejemplo'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Añade más provincias según sea necesario
        ],
      ),
    );
  }
}


