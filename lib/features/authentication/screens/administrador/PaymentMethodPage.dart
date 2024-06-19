import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentMethod;

  const PaymentMethodPage({Key? key, required this.paymentMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: paymentMethod,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(name: '', entity: 'Método de Cobro', isNew: true),
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
                builder: (context) => DetailsDialog(name: 'Por metro cuadrado', entity: 'Método de Cobro'),
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
                      'Por metro cuadrado',
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
                      // No se hace nada al presionar los tres puntos en métodos de cobro
                    },
                  ),
                ],
              ),
            ),
          ),
          // Añade más métodos de cobro según sea necesario
        ],
      ),
    );
  }
}
