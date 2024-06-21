import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CategoryListItem.dart';

class ProvincePage extends StatelessWidget {
  final String provinceName;

  const ProvincePage({Key? key, required this.provinceName}) : super(key: key);

  void _saveProvince() {
    // Implementa la lógica de guardar la provincia en la base de datos
    // Por ejemplo: saveProvinceToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: provinceName,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(
              name: '',
              entity: 'Distrito',
              isNew: true,
              onSave: _saveProvince,  // Añadido
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CategoryListItem(
            name: 'Distrito de Ejemplo',
            imagePath: null,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailsDialog(
                  name: 'Distrito de Ejemplo',
                  entity: 'Distrito',
                  onSave: _saveProvince,  // Añadido
                ),
              );
            },
            onMorePressed: () {
              // Los tres puntos no hacen nada en los distritos
            },
          ),
          // Añade más distritos según sea necesario
        ],
      ),
    );
  }
}