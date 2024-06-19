import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';

class ProvincePage extends StatelessWidget {
  final String provinceName;

  const ProvincePage({Key? key, required this.provinceName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: provinceName,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(name: '', entity: 'Distrito', isNew: true),
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
                builder: (context) => DetailsDialog(name: 'Distrito de Ejemplo', entity: 'Distrito'),
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
                      'Distrito de Ejemplo',
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
                      // Los tres puntos no hacen nada en los distritos
                    },
                  ),
                ],
              ),
            ),
          ),
          // Añade más distritos según sea necesario
        ],
      ),
    );
  }
}
