import 'package:flutter/material.dart';

class PagosPage extends StatelessWidget {
  final List<Map<String, dynamic>> pagos = [
    {
      'nombre': 'André Talavera',
      'idPago': '#01011',
      'idIdentificacion': '#01000',
      'estadoPago': 'Pago Adelantado',
      'metodoPago': 'Presencial',
      'cantidad': 'S/ 60.00',
    },
    {
      'nombre': 'André Talavera',
      'idPago': '#01010',
      'idIdentificacion': '#00999',
      'estadoPago': 'Pago en Línea',
      'metodoPago': 'Presencial',
      'cantidad': 'S/ 50.00',
    },
    {
      'nombre': 'Mateo Rojas',
      'idPago': '#01017',
      'idIdentificacion': '#00998',
      'estadoPago': 'Pago Adelantado',
      'metodoPago': 'Presencial',
      'cantidad': 'S/ 60.00',
    },
    // Agrega más pagos aquí según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: pagos.length,
        itemBuilder: (context, index) {
          final pago = pagos[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pago['nombre'],
                    style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Identificación de Pago',
                        style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        pago['idPago'],
                        style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 14, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estado del Pago',
                        style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        pago['estadoPago'],
                        style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Método de Pago',
                        style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        pago['metodoPago'],
                        style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cantidad',
                        style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        pago['cantidad'],
                        style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PagosPage(),
  ));
}
