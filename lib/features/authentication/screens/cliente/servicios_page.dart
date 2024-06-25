import 'package:flutter/material.dart';
import 'ReservaServicioPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../url.dart';

class ServiciosPage extends StatefulWidget {
  final Map<String, dynamic> user;

  ServiciosPage({required this.user});

  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  double _minPrice = 0;
  double _maxPrice = 5000;
  RangeValues _priceRange = RangeValues(0, 5000);
  List<bool> _selectedRatings = [false, false, false, false, false];
  List<String> _categories = ['Carpintería', 'Electricidad', 'Fontanería', 'Pintura', 'Jardinería'];
  List<IconData> _categoryIcons = [Icons.handyman, Icons.electrical_services, Icons.plumbing, Icons.format_paint, Icons.grass];
  List<bool> _selectedCategories = [false, false, false, false, false];
  List<dynamic> _services = [];

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  void _loadServiceData() async {
    var url1 = ruta + "/servicioscliente";
    final uri = Uri.parse(url1);
    final client = http.Client();
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final servicios = json.decode(response.body);
        setState(() {
          _services = servicios;
        });
        print(_services);
        print("Datos guardados");
        print(_services.length);
      } else {
        print("Error " + response.statusCode.toString());
      }
    } catch (e) {
      print("Error: " + e.toString());
    } finally {
      client.close();
    }
  }

  void _applyFilters() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _services.length, // Cantidad de elementos en la lista _services
      itemBuilder: (context, index) {
        var service = _services[index]; // Obtiene el servicio actual basado en el índice
        print("Número de servicio: " + index.toString());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width, // Usa el ancho de la pantalla
                  height: 180, // Altura fija
                  // Uncomment this section to display the image if URLs are provided
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  //   child: Image.network(
                  //     service['imageUrl'], // URL de la imagen del servicio
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      service['servicio']['subcategoria']['categoria']['nombre'], // Categoría del servicio
                      style: TextStyle(color: Colors.white, fontFamily: 'Mont-Regular'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Aquí puedes agregar la lógica para mostrar las estrellas basadas en las reseñas
                  SizedBox(height: 8),
                  Text(
                    service['servicio']['nombre'], // Nombre del servicio
                    style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'S/ ${service['servicio']['precio']}', // Precio del servicio
                    style: TextStyle(color: Colors.green, fontFamily: 'Mont-Bold', fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      // Uncomment this section to display the image if URLs are provided
                      // CircleAvatar(
                      //   backgroundImage: NetworkImage(service['foto']), // Imagen del proveedor
                      //   radius: 15,
                      // ),
                      SizedBox(width: 8),
                      Text(
                        service['usuario']['nombre'] + ' ' + service['usuario']['apellido'], // Nombre del proveedor
                        style: TextStyle(fontFamily: 'Mont-Regular'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
