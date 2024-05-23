import 'package:flutter/material.dart';
import 'AddServicePage.dart'; // Importa la página AddServicePage

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          'Servicios',
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
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddServicePage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildServiceCard(
            context,
            'assets/images/armarios.png', // Ruta de la imagen del servicio (actualiza esta ruta según corresponda)
            'Carpintería',
            4, // Calificación en estrellas
            'Armarios y vestidores a medida',
            150,
            'assets/images/jonathan.jpg', // Ruta de la imagen del proveedor
            'Jonathan Mamani',
          ),
          _buildServiceCard(
            context,
            'assets/images/armarios.png', // Ruta de la imagen del servicio
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

  Widget _buildServiceCard(
      BuildContext context,
      String serviceImagePath,
      String category,
      int rating,
      String serviceName,
      int price,
      String providerImagePath,
      String providerName,
      ) {
    return GestureDetector(
      onTap: () {
        _showServiceDetail(context, serviceImagePath, category, rating, serviceName, price, providerImagePath, providerName);
      },
      child: Card(
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
                    'S/ $price por 1:00 hr',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showServiceDetail(
      BuildContext context,
      String serviceImagePath,
      String category,
      int rating,
      String serviceName,
      int price,
      String providerImagePath,
      String providerName,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(0),
          child: Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      serviceImagePath,
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        actions: [
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                // Lógica para editar
                              } else if (value == 'delete') {
                                // Lógica para eliminar
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'Editar', 'Eliminar'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice.toLowerCase(),
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'S/ $price por 1:00 hr',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(providerImagePath),
                                radius: 20,
                              ),
                              SizedBox(width: 8),
                              Text(providerName),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Descripción del servicio...',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Distritos disponibles:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Distritos disponibles 1\nDistritos disponibles 2\nDistritos disponibles 3',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Reseñas:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _buildReviewCard(
                            'assets/images/mateo.jpg',
                            'Mateo Mamani',
                            'Febrero 15, 2024',
                            4,
                            'Fue un muy buen servicio, todo quedo muy lindo.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewCard(String imagePath, String name, String date, int rating, String comment) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 30,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
                SizedBox(height: 4),
                Text(comment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}