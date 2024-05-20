import 'package:flutter/material.dart';

class FavoriteProvidersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          'Proveedores Favoritos',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildFavoriteProviderCard(
              'assets/images/jonathan.jpg', // Ruta de la imagen del proveedor
              'Jonathan Mamani',
              4,
            ),
            _buildFavoriteProviderCard(
              'assets/images/manuel.jpeg', // Ruta de la imagen del proveedor
              'Manuel Romero',
              4,
            ),
            // Añadir más proveedores aquí
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteProviderCard(
      String providerImagePath,
      String providerName,
      int rating,
      ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(providerImagePath),
                radius: 40,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            providerName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
        ],
      ),
    );
  }
}



