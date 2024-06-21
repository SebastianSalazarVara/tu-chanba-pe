import 'package:flutter/material.dart';
import '../../../../common_widgets/CommentWidget.dart';
import '../../../../common_widgets/ServiceCardWidget.dart';
import 'AddServicePage.dart'; // Importa la página AddServicePage

class ServicesPage extends StatefulWidget {
  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Map<String, dynamic>> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  void fetchServices() {
    print("Fetching services from database...");
    // Simulamos la obtención de datos de una base de datos
    setState(() {
      services = [
        {
          'id': 1, // Identificador único del servicio
          'serviceImagePath': 'assets/images/armarios.png',
          'category': 'Carpintería',
          'rating': 4,
          'serviceName': 'Armarios y vestidores a medida',
          'price': 150,
          'providerImagePath': 'assets/images/jonathan.jpg',
          'providerName': 'Jonathan Mamani',
          'comments': [
            Comment(
              imagePath: 'assets/images/mateo.jpg',
              name: 'Mateo Mamani',
              date: 'Febrero 15, 2024',
              rating: 4,
              comment: 'Fue un muy buen servicio, todo quedo muy lindo.',
            ),
          ],
        },
        // Agrega más servicios si es necesario
      ];
    });
  }

  // Método para editar un servicio
  void editService(int id) {
    print("Edit service with id $id");
    // Aquí agregarías la lógica para editar el servicio
    // Por ejemplo, podrías abrir una página de edición y pasar los datos del servicio
  }

  // Método para eliminar un servicio
  void deleteService(int id) {
    print("Delete service with id $id");
    // Simula la eliminación del servicio de la lista
    setState(() {
      services.removeWhere((service) => service['id'] == id);
    });
  }

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
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return ServiceCardWidget(
            serviceImagePath: service['serviceImagePath'],
            category: service['category'],
            rating: service['rating'],
            serviceName: service['serviceName'],
            price: service['price'],
            providerImagePath: service['providerImagePath'],
            providerName: service['providerName'],
            comments: service['comments'],
            onEdit: () => editService(service['id']), // Conectar método editar
            onDelete: () => deleteService(service['id']), // Conectar método eliminar
          );
        },
      ),
    );
  }
}


