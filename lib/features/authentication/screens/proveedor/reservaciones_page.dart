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
      "cliente": "André Talavera",
      "id": "#01011"
    },
    {
      "estado": "En Espera",
      "precio": "S/ 500.00",
      "direccion": "Calle 123 asd",
      "fecha": "15 de octubre, 2024 a las 16:00 pm",
      "cliente": "Mateo Romero",
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
        title: Text('Reservaciones'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            color: Color(0xFF6286CB),
            onPressed: () => _mostrarFiltros(context),
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
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/armarios.png'),
                  radius: 24,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(reserva['id']),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(reserva['precio'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Dirección: ${reserva['direccion']}"),
            Text("Día y Hora: ${reserva['fecha']}"),
            Text("Cliente: ${reserva['cliente']}"),
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

