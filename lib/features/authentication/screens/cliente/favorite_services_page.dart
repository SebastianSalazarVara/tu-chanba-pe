import 'package:flutter/material.dart';

class FavoriteServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          'Servicios Favoritos',
          style: TextStyle(
            fontFamily: 'Mont-Bold',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          _buildFavoriteServiceCard(
            context,
            'assets/images/armarios.jpg', // Ruta de la imagen del servicio
            'Carpintería',
            4, // Calificación en estrellas
            'Armarios y vestidores a medida',
            150,
            'assets/images/jonathan.jpg', // Ruta de la imagen del proveedor
            'Jonathan Mamani',
          ),
          _buildFavoriteServiceCard(
            context,
            'assets/images/armarios.jpg', // Ruta de la imagen del servicio
            'Carpintería',
            4, // Calificación en estrellas
            'Instalación de Pisos de Parquet',
            500,
            'assets/images/jonathan.jpg', // Ruta de la imagen del proveedor
            'Jonathan Mamani',
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteServiceCard(
      BuildContext context,
      String serviceImagePath,
      String category,
      int rating,
      String serviceName,
      int price,
      String providerImagePath,
      String providerName,
      ) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(serviceImagePath, fit: BoxFit.cover, height: 150, width: double.infinity),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                SizedBox(height: 8),
                Text(
                  serviceName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'S/ $price',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(providerImagePath),
                      radius: 15,
                    ),
                    SizedBox(width: 8),
                    Text(providerName),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        // Acción al presionar el corazón
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

