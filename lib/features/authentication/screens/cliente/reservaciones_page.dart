import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../url.dart';
import 'package:url_launcher/url_launcher.dart'; // Import para llamadas

class ReservacionesPage extends StatefulWidget {
  final Map<String, dynamic> user;

  ReservacionesPage({required this.user});

  @override
  _ReservacionesPageState createState() => _ReservacionesPageState();
}

class _ReservacionesPageState extends State<ReservacionesPage> {
  final Map<String, dynamic> reserva = {
    "precio": "S/ 500.00",
    "direccion": "Calle 123 asd",
    "fecha": "15 de octubre, 2024",
    "hora": "16:00 pm",
    "proveedor": "Mateo Romero",
    "correo": "Mateo@user.com",
    "id": "#01010",
    "descripcion": "Se quiere que diseñe y realice un armario con las medidas...",
    "telefono": "123456789", // Número de teléfono preestablecido
  };

  final List<dynamic> reservas = [];

  @override
  void initState() {
    super.initState();
    String idUsuario = _getIdUsuario();
    _loadServiceData(idUsuario);
  }

  String _getIdUsuario() {
    return widget.user['idUsuario'];
  }

  void _loadServiceData(String idUsuario) async {
    var url1 = ruta + "/reservacionesproveedor/" + idUsuario;
    final uri = Uri.parse(url1);
    final client = http.Client();
    try {
      final response = await client.get(uri);
      final decodedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          reservas.addAll(decodedData);
        });
        print("MOSTRANDO LAS RESERVAS OBTENIDAS");
        print(reservas);
      }
    } catch (e) {
      print("hay un error y es " + e.toString());
    } finally {
      client.close();
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      if (await canLaunch(phoneUri.toString())) {
        await launch(phoneUri.toString());
      } else {
        throw 'No se puede hacer la llamada';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          _buildReservacionCard(reserva),
        ],
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
                          IconButton(
                            icon: Icon(Icons.call, color: Color(0xFF6286CB)),
                            onPressed: () => _makePhoneCall(reserva['telefono'] ?? '123456789'),
                          ),
                          Text(
                            reserva['id'] ?? 'Sin ID',
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
                        reserva['precio'] ?? 'S/ 0.00',
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
                    reserva['direccion'] ?? 'Sin Dirección',
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
                  "${reserva['fecha'] ?? 'Sin Fecha'} a las ${reserva['hora'] ?? 'Sin Hora'}",
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Proveedor:", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  reserva['proveedor'] ?? 'Sin Proveedor',
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
