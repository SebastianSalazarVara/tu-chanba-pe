import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailsDialog.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CategoryListItem.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentMethod;

  const PaymentMethodPage({Key? key, required this.paymentMethod}) : super(key: key);

  void _savePaymentMethod() {
    // Implementa la lógica de guardar el método de cobro en la base de datos
    // Por ejemplo: savePaymentMethodToDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: paymentMethod,
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailsDialog(
              name: '',
              entity: 'Método de Cobro',
              isNew: true,
              onSave: _savePaymentMethod,  // Añadido
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CategoryListItem(
            name: 'Por metro cuadrado',
            imagePath: null,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailsDialog(
                  name: 'Por metro cuadrado',
                  entity: 'Método de Cobro',
                  onSave: _savePaymentMethod,  // Añadido
                ),
              );
            },
            onMorePressed: () {
              // No se hace nada al presionar los tres puntos en métodos de cobro
            },
          ),
          // Añade más métodos de cobro según sea necesario
        ],
      ),
    );
  }
}
