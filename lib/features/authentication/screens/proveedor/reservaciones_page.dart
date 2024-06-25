import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa la biblioteca para realizar llamadas

class ReservacionesPage extends StatefulWidget {
  final Map<String, dynamic> user;

  ReservacionesPage({required this.user});

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
      "telefono": "1234567890", // Número de teléfono del proveedor
      "correo": "proveedor@ejemplo.com",
      "descripcion": "Descripción de la reserva",
      "precioAdelantado": "S/ 50.00"
    }
  ];

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  void _loadServiceData() {
    // Cargar datos del servicio
    print("Cargando datos del servicio...");
  }

  // Método para realizar una llamada
  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print("No se pudo realizar la llamada a $phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: reservaciones.map((reserva) => _buildReservacionCard(reserva)).toList(),
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
                IconButton(
                  icon: Icon(Icons.call, color: Colors.blue), // Ícono de llamada
                  onPressed: () => makePhoneCall(reserva['telefono']), // Llamada al presionar
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReservacionesPage(user: {}),
  ));
}
