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
      "id": "#01011",
      "servicio": "Armarios y vestidores a medida",
      "hora": "4:00 pm",
      "proveedor": "Proveedor Ejemplo",
      "correo": "proveedor@ejemplo.com",
      "descripcion": "Descripción de la reserva",
      "precioAdelantado": "S/ 50.00"
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
    return InkWell(
      onTap: () {
        // Redirecciona a la página de ReservaDetallesPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReservaDetallesPage(reserva: reserva)),
        );
      },
      child: Card(
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
                          reserva['servicio'],
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
                  Text("Cliente:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    reserva['cliente'],
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
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

class ReservaDetallesPage extends StatelessWidget {
  final Map<String, dynamic> reserva;

  ReservaDetallesPage({required this.reserva});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reserva['estado'] ?? 'Sin Estado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ID de Reserva", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(reserva['id'] ?? 'Sin ID', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16),
            Text("Armarios y vestidores a medida", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Día:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(reserva['fecha'] ?? 'Sin Fecha'),
                    SizedBox(height: 8),
                    Text("Hora:", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(reserva['hora'] ?? 'Sin Hora'),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/armarios.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text("Cliente", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/cliente.png'), // Imagen del cliente
                ),
                title: Text(reserva['proveedor'] ?? 'Nombre Cliente'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reserva['correo'] ?? ' Correo'),
                    Text(reserva['direccion'] ?? 'Dirección'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {
                        // Acción para llamar al cliente
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () {
                        // Acción para chatear con el cliente
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Descripción de la Reserva", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(reserva['descripcion'] ?? 'Sin Descripción'),
            SizedBox(height: 16),
            Text("Detalles del Precio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Precio Total:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(reserva['precio'] ?? 'S/ 0.00'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Pago Adelantado:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(reserva['precioAdelantado'] ?? 'S/ 0.00'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acción para confirmar el pago
              },
              child: Text('Realizar Pago'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6286CB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReservacionesPage(),
  ));
}
