import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  // Variable para controlar el estado del corazón (favorito)
  List<bool> _isFavorite = [false, false]; // Suponiendo que tenemos dos servicios

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            filled: true,
            contentPadding: EdgeInsets.all(0),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: Colors.blue),
            onPressed: () {
              // Acción del botón de filtros
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 2, // Cambia esto según la cantidad de servicios que tengas
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Acción al presionar la tarjeta completa
            },
            child: Card(
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.network(
                          index == 0
                              ? 'https://example.com/imagen1.jpg'
                              : 'https://example.com/imagen2.jpg',
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
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
                            'Carpintería',
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
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            Icon(Icons.star_border, color: Colors.grey, size: 20),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          index == 0
                              ? 'Armarios y vestidores a medida'
                              : 'Instalación de Pisos de Parquet',
                          style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Text(
                          index == 0 ? 'S/ 150' : 'S/ 500',
                          style: TextStyle(color: Colors.green, fontFamily: 'Mont-Bold', fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('https://example.com/perfil.jpg'),
                                  radius: 15,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Jonathan Mamani',
                                  style: TextStyle(fontFamily: 'Mont-Regular'),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                _isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                                color: _isFavorite[index] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isFavorite[index] = !_isFavorite[index];
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
