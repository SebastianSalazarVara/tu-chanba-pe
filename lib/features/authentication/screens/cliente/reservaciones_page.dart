import 'package:flutter/material.dart';

class ReservacionesPage extends StatefulWidget {
  @override
  _ReservacionesPageState createState() => _ReservacionesPageState();
}

class _ReservacionesPageState extends State<ReservacionesPage> {
  final List<Map<String, dynamic>> reservaciones = [
    {
      "estado": "Completado",
      "precio": "S/ 110.00",
      "direccion": "Calle 123 asd",
      "fecha": "10 de octubre, 2024 a las 4:00 pm",
      "proveedor": "André Talavera",
      "id": "#01011"
    },
    {
      "estado": "En Espera",
      "precio": "S/ 500.00",
      "direccion": "Calle 123 asd",
      "fecha": "15 de octubre, 2024 a las 16:00 pm",
      "proveedor": "Mateo Romero",
      "id": "#01010"
    }
  ];

  final List<String> estados = [
    "Completado",
    "En Espera",
    "Cancelado",
    "Rechazado",
    "En Progreso",
    "Aceptado"
  ];

  final Set<String> filtrosSeleccionados = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _mostrarFiltros(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF6286CB),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Icon(Icons.filter_list, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: reservaciones
            .where((reserva) => filtrosSeleccionados.isEmpty || filtrosSeleccionados.contains(reserva['estado']))
            .map((reserva) => _buildReservacionCard(reserva))
            .toList(),
      ),
    );
  }

  Widget _buildReservacionCard(Map<String, dynamic> reserva) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/armarios.png',
                    width: 82,
                    height: 82,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: reserva['estado'] == "Completado" ? Colors.green : Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              reserva['estado'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text(
                            reserva['id'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6286CB),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Armarios y vestidores a medida",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mont-Bold',
                        ),
                      ),
                      Text(
                        reserva['precio'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                          fontFamily: 'Mont-Bold',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dirección:", style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: Text(
                    reserva['direccion'],
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Día y Hora:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  reserva['fecha'],
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Proveedor:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  reserva['proveedor'],
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarFiltros(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Filtrado por', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: estados.map((estado) {
                      final bool isSelected = filtrosSeleccionados.contains(estado);
                      return FilterChip(
                        label: Text(estado),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              filtrosSeleccionados.add(estado);
                            } else {
                              filtrosSeleccionados.remove(estado);
                            }
                          });
                        },
                        checkmarkColor: Colors.white,
                        selectedColor: Color(0xFF99B2E1),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            filtrosSeleccionados.clear();
                          });
                        },
                        child: Text('Limpiar Filtros'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: Text('Aplicar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6286CB),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReservacionesPage(),
  ));
}
