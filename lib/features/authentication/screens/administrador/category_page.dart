import 'package:flutter/material.dart';

import '../../../../common_widgets/DetailDialogCategory.dart';
import '../../../../common_widgets/TopBar.dart';
import 'subcategory_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../url.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
    @override
    void initState() {
      super.initState();
      _getCategories();
    }
    
    Future<void> _getCategories() async {
      try {
        var url1=ruta+'/categoria';
        final uri = Uri.parse(url1);
        final client = http.Client();
        final response = await client.get(uri);
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
        } else {
          print('Error al obtener las categorías');
        }
      } catch (e) {
        print('Error al obtener las categorías'+e.toString());
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Categorías',
        showBackButton: true,
        onAddPressed: () {
          showDialog(
            context: context,
            builder: (context) => DetailDialogCategory(
              title: 'Añadir Categoría',
              name: '',
              image: 'assets/images/default.png',
              onDelete: () {
                // Implementa la lógica para eliminar la categoría
                print("Ingreso a eliminar");
                Navigator.pop(context); // Cierra el diálogo después de eliminar
              },


            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DetailDialogCategory(
                  title: 'Editar Categoría',
                  name: 'Mecánico',
                  image: 'assets/images/mecanico.png',
                  onDelete: () {
                    // Implementa la lógica para eliminar la categoría
                    Navigator.pop(context); // Cierra el diálogo después de eliminar
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/mecanico.png'),
                    radius: 30,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Mecánico',
                      style: TextStyle(
                        fontFamily: 'Mont-Bold',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubcategoryPage(categoryName: 'Mecánico'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Añade más categorías según sea necesario
        ],
      ),
    );
  }
}


