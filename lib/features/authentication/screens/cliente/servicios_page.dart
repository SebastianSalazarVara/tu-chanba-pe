import 'package:flutter/material.dart';

class ServiciosPage extends StatefulWidget {
  @override
  _ServiciosPageState createState() => _ServiciosPageState();
}

class _ServiciosPageState extends State<ServiciosPage> {
  List<bool> _isFavorite = [false, false];
  double _minPrice = 0;
  double _maxPrice = 5000;
  RangeValues _priceRange = RangeValues(0, 5000);
  List<bool> _selectedRatings = [false, false, false, false, false];
  List<String> _categories = ['Carpintería', 'Electricidad', 'Fontanería', 'Pintura', 'Jardinería'];
  List<IconData> _categoryIcons = [Icons.handyman, Icons.electrical_services, Icons.plumbing, Icons.format_paint, Icons.grass];
  List<bool> _selectedCategories = [false, false, false, false, false];
  List<bool> _expandedSections = [false, false, false, false];

  void _applyFilters() {
    // Aquí iría la lógica para aplicar los filtros
    Navigator.pop(context);
  }

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
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.filter_alt_outlined, color: Colors.blue),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
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
                        child: Image.asset(
                          index == 0
                              ? 'assets/images/armarios.jpg'
                              : 'assets/images/pisos.jpg',
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
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < 4 ? Icons.star : Icons.star_border,
                              color: starIndex < 4 ? Colors.green : Colors.grey,
                              size: 20,
                            );
                          }),
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
                                  backgroundImage: AssetImage('assets/images/jonathan.jpg'),
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text('Filtrar Servicio', style: TextStyle(fontSize: 24, fontFamily: 'Mont-Bold')),
            SizedBox(height: 20),
            ExpansionTile(
              title: Text('Proveedor', style: TextStyle(fontFamily: 'Mont-Bold')),
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/jonathan.jpg'),
                  ),
                  title: Text('Proveedor 1', style: TextStyle(fontFamily: 'Mont-Regular')),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/jonathan.jpg'),
                  ),
                  title: Text('Proveedor 2', style: TextStyle(fontFamily: 'Mont-Regular')),
                  trailing: Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Categoría', style: TextStyle(fontFamily: 'Mont-Bold')),
              children: _categories.map((category) {
                int index = _categories.indexOf(category);
                return ListTile(
                  leading: Icon(_categoryIcons[index]),
                  title: Text(category, style: TextStyle(fontFamily: 'Mont-Regular')),
                  trailing: Checkbox(
                    value: _selectedCategories[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategories[index] = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            ExpansionTile(
              title: Text('Precio', style: TextStyle(fontFamily: 'Mont-Bold')),
              children: [
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 5000,
                  divisions: 100,
                  labels: RangeLabels(
                    _priceRange.start.round().toString(),
                    _priceRange.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('S/ ${_priceRange.start.round()}', style: TextStyle(fontFamily: 'Mont-Regular')),
                    Text('S/ ${_priceRange.end.round()}', style: TextStyle(fontFamily: 'Mont-Regular')),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Calificación', style: TextStyle(fontFamily: 'Mont-Bold')),
              children: List.generate(5, (index) {
                return CheckboxListTile(
                  value: _selectedRatings[index],
                  title: Row(
                    children: List.generate(5, (starIndex) {
                      Color starColor;
                      if (index >= 4) {
                        starColor = Colors.green;
                      } else if (index == 3) {
                        starColor = Colors.orange;
                      } else {
                        starColor = Colors.yellow;
                      }
                      return Icon(
                        starIndex <= index ? Icons.star : Icons.star_border,
                        color: starIndex <= index ? starColor : Colors.grey,
                      );
                    }),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedRatings[index] = value!;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6286CB),
              ),
              child: Text('Aplicar Filtros', style: TextStyle(fontFamily: 'Mont-Bold', color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}