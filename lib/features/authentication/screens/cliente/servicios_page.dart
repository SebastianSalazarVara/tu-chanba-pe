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
  List<bool> _isFavorite = [false];
  double _minPrice = 0;
  double _maxPrice = 5000;
  RangeValues _priceRange = RangeValues(0, 5000);
  List<bool> _selectedRatings = [false, false, false, false, false];
  List<String> _categories = ['Carpintería', 'Electricidad', 'Fontanería', 'Pintura', 'Jardinería'];
  List<IconData> _categoryIcons = [Icons.handyman, Icons.electrical_services, Icons.plumbing, Icons.format_paint, Icons.grass];
  List<bool> _selectedCategories = [false, false, false, false, false];
  List<bool> _expandedSections = [false, false, false, false];
  List<dynamic> _services = [];

  @override
  void initState() {
    super.initState();
    _loadServiceData();
  }

  void _loadServiceData() async {
    var url1= ruta+"/servicioscliente";
    final uri = Uri.parse(url1);
    final client = http.Client();
    try {
      final response = await client.get(uri);
      if(response.statusCode == 200){
        final servicios = json.decode(response.body);
        setState(() {
          _services = servicios;
        });
        print(_services);
        print("se guardo los datos");
        print(_services.length);
      }
      else{
        print("Error "+ response.statusCode.toString());
      }
    } catch (e) {
      print("error" + e.toString());
    } finally {
      client.close();
    }
  }

  void _applyFilters() {
    // Aquí iría la lógica para aplicar los filtros
    Navigator.pop(context);
  }

  // void _showServiceDetails(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return DraggableScrollableSheet(
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return SingleChildScrollView(
  //             controller: scrollController,
  //             child: Padding(
  //               padding: const EdgeInsets.all(16.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(15),
  //                     child: Image.asset(
  //                       'assets/images/armarios.png',  // Imagen del servicio de armarios
  //                       height: 180,
  //                       width: double.infinity,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Carpintería > Muebles', style: TextStyle(color: Colors.grey)),
  //                   SizedBox(height: 8),
  //                   Row(
  //                     children: List.generate(5, (starIndex) {
  //                       return Icon(
  //                         starIndex < 4 ? Icons.star : Icons.star_border,
  //                         color: starIndex < 4 ? Colors.green : Colors.grey,
  //                         size: 20,
  //                       );
  //                     }),
  //                   ),
  //                   SizedBox(height: 8),
  //                   Text(
  //                     'Armarios y vestidores a medida',
  //                     style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
  //                   ),
  //                   SizedBox(height: 4),
  //                   Text(
  //                     'S/ 150 por: 1:00 hr',
  //                     style: TextStyle(color: Colors.green, fontFamily: 'Mont-Bold', fontSize: 16),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Descripción', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16)),
  //                   SizedBox(height: 4),
  //                   Text('aca se coloca la descripción de ........', style: TextStyle(fontFamily: 'Mont-Regular')),
  //                   SizedBox(height: 16),
  //                   Text('Distritos', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16)),
  //                   SizedBox(height: 4),
  //                   Text('Distritos disponibles 1', style: TextStyle(fontFamily: 'Mont-Regular')),
  //                   Text('Distritos disponibles 2', style: TextStyle(fontFamily: 'Mont-Regular')),
  //                   SizedBox(height: 16),
  //                   Text('Proveedor', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16)),
  //                   SizedBox(height: 8),
  //                   Row(
  //                     children: [
  //                       CircleAvatar(
  //                         backgroundImage: AssetImage('assets/images/jonathan.jpg'),
  //                         radius: 30,
  //                       ),
  //                       SizedBox(width: 16),
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text('Mateo Romero', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16)),
  //                           Text('Este servicio se realiza de manera óptima ...', style: TextStyle(fontFamily: 'Mont-Regular')),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 16),
  //                   Text('Reseñas', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16)),
  //                   SizedBox(height: 8),
  //                   ListTile(
  //                     leading: CircleAvatar(
  //                       backgroundImage: AssetImage('assets/images/jonathan.jpg'),
  //                     ),
  //                     title: Text('Mateo Mamani', style: TextStyle(fontFamily: 'Mont-Bold')),
  //                     subtitle: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           children: List.generate(5, (starIndex) {
  //                             return Icon(
  //                               starIndex < 4 ? Icons.star : Icons.star_border,
  //                               color: starIndex < 4 ? Colors.green : Colors.grey,
  //                               size: 16,
  //                             );
  //                           }),
  //                         ),
  //                         SizedBox(height: 4),
  //                         Text('Febrero 15, 2024', style: TextStyle(fontFamily: 'Mont-Regular')),
  //                         SizedBox(height: 4),
  //                         Text('Fue un muy buen servicio, todo quedo muy lindo.', style: TextStyle(fontFamily: 'Mont-Regular')),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(height: 16),
  //                   Center(
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         // Lógica para reservar el servicio
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) => ReservaServicioPage()),
  //                         );
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: Color(0xFF6286CB),
  //                         padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  //                       ),
  //                       child: Text('Reservar ahora', style: TextStyle(fontFamily: 'Mont-Bold', color: Colors.white)),
  //                     ),
  //                   ),
  //                   SizedBox(height: 16),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: TextField(
//           decoration: InputDecoration(
//             hintText: 'Buscar',
//             prefixIcon: Icon(Icons.search, color: Colors.grey),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             contentPadding: EdgeInsets.all(0),
//           ),
//         ),
//         actions: [
//           Builder(
//             builder: (context) {
//               return IconButton(
//                 icon: Icon(Icons.filter_alt_outlined, color: Colors.blue),
//                 onPressed: () {
//                   Scaffold.of(context).openEndDrawer();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: 1,  // Solo una tarjeta
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               _showServiceDetails(context);
//             },
//             child: Card(
//               margin: EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//                         child: Image.asset(
//                           'assets/images/armarios.png',  // Imagen del servicio de armarios
//                           height: 180,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         top: 10,
//                         left: 10,
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             'Carpintería',
//                             style: TextStyle(color: Colors.white, fontFamily: 'Mont-Regular'),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: List.generate(5, (starIndex) {
//                             return Icon(
//                               starIndex < 4 ? Icons.star : Icons.star_border,
//                               color: starIndex < 4 ? Colors.green : Colors.grey,
//                               size: 20,
//                             );
//                           }),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Armarios y vestidores a medida',
//                           style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           'S/ 150',
//                           style: TextStyle(color: Colors.green, fontFamily: 'Mont-Bold', fontSize: 16),
//                         ),
//                         SizedBox(height: 4),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundImage: AssetImage('assets/images/jonathan.jpg'),
//                                   radius: 15,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'Jonathan Mamani',
//                                   style: TextStyle(fontFamily: 'Mont-Regular'),
//                                 ),
//                               ],
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 _isFavorite[index] ? Icons.favorite : Icons.favorite_border,
//                                 color: _isFavorite[index] ? Colors.red : Colors.grey,
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   _isFavorite[index] = !_isFavorite[index];
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       endDrawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.all(16),
//           children: [
//             Text('Filtrar Servicio', style: TextStyle(fontSize: 24, fontFamily: 'Mont-Bold')),
//             SizedBox(height: 20),
//             ExpansionTile(
//               title: Text('Proveedor', style: TextStyle(fontFamily: 'Mont-Bold')),
//               children: [
//                 ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: AssetImage('assets/images/jonathan.jpg'),
//                   ),
//                   title: Text('Proveedor 1', style: TextStyle(fontFamily: 'Mont-Regular')),
//                   trailing: Checkbox(
//                     value: false,
//                     onChanged: (value) {},
//                   ),
//                 ),
//                 ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: AssetImage('assets/images/jonathan.jpg'),
//                   ),
//                   title: Text('Proveedor 2', style: TextStyle(fontFamily: 'Mont-Regular')),
//                   trailing: Checkbox(
//                     value: false,
//                     onChanged: (value) {},
//                   ),
//                 ),
//               ],
//             ),
//             ExpansionTile(
//               title: Text('Categoría', style: TextStyle(fontFamily: 'Mont-Bold')),
//               children: _categories.map((category) {
//                 int index = _categories.indexOf(category);
//                 return ListTile(
//                   leading: Icon(_categoryIcons[index]),
//                   title: Text(category, style: TextStyle(fontFamily: 'Mont-Regular')),
//                   trailing: Checkbox(
//                     value: _selectedCategories[index],
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedCategories[index] = value!;
//                       });
//                     },
//                   ),
//                 );
//               }).toList(),
//             ),
//             ExpansionTile(
//               title: Text('Precio', style: TextStyle(fontFamily: 'Mont-Bold')),
//               children: [
//                 RangeSlider(
//                   values: _priceRange,
//                   min: 0,
//                   max: 5000,
//                   divisions: 100,
//                   labels: RangeLabels(
//                     _priceRange.start.round().toString(),
//                     _priceRange.end.round().toString(),
//                   ),
//                   onChanged: (RangeValues values) {
//                     setState(() {
//                       _priceRange = values;
//                     });
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('S/ ${_priceRange.start.round()}', style: TextStyle(fontFamily: 'Mont-Regular')),
//                     Text('S/ ${_priceRange.end.round()}', style: TextStyle(fontFamily: 'Mont-Regular')),
//                   ],
//                 ),
//               ],
//             ),
//             ExpansionTile(
//               title: Text('Calificación', style: TextStyle(fontFamily: 'Mont-Bold')),
//               children: List.generate(5, (index) {
//                 return CheckboxListTile(
//                   value: _selectedRatings[index],
//                   title: Row(
//                     children: List.generate(5, (starIndex) {
//                       Color starColor;
//                       if (index >= 4) {
//                         starColor = Colors.green;
//                       } else if (index == 3) {
//                         starColor = Colors.orange;
//                       } else {
//                         starColor = Colors.yellow;
//                       }
//                       return Icon(
//                         starIndex <= index ? Icons.star : Icons.star_border,
//                         color: starIndex <= index ? starColor : Colors.grey,
//                       );
//                     }),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedRatings[index] = value!;
//                     });
//                   },
//                 );
//               }),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _applyFilters,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF6286CB),
//               ),
//               child: Text('Aplicar Filtros', style: TextStyle(fontFamily: 'Mont-Bold', color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


@override
Widget build(BuildContext context) {
  return ListView.builder(
    itemCount: _services.length-1, // La cantidad de elementos en la lista _services
    itemBuilder: (context, index) {
      var service = _services[index]; // Obtiene el servicio actual basado en el índice
      print("numero de servicio: "+index.toString());
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width, // Usa el ancho de la pantalla para definir un tamaño finito
                height: 180, // Altura fija
                // child: ClipRRect(
                //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                //   child: Image.network( // Cambiado de Image.asset a Image.network
                //     service['imageUrl'], // Usa la URL de la imagen del servicio
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
                    service['servicio']['subcategoria']['categoria']['nombre'], // Usa la categoría del servicio
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
                  service['servicio']['nombre'], // Usa el nombre del servicio
                  style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'S/ ${service['servicio']['precio']}', // Usa el precio del servicio
                  style: TextStyle(color: Colors.green, fontFamily: 'Mont-Bold', fontSize: 16),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: NetworkImage(service['foto']), // Usa la imagen del proveedor
                        //   radius: 15,
                        // ),
                        SizedBox(width: 8),
                        Text(
                          service['usuario']['nombre']+ service['usuario']['apellido'], // Usa el nombre del proveedor
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
      );
    },
  );
}


}
