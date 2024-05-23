import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _selectedSubCategory;
  String? _selectedDistrict;
  bool _isPrepaid = false;
  bool _isActive = true;
  File? _image;
  double? _prepaidPercentage;
  List<String> _selectedDays = [];
  Map<String, List<TimeOfDay>> _selectedTimes = {};
  String? _chargeMode;
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _prepaidPercentageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final Map<String, List<String>> _categories = {
    'Carpintería': [
      'Muebles a medida',
      'Reparación de puertas y ventanas',
      'Instalación de pisos de madera'
    ],
    'Electricidad': [
      'Instalaciones eléctricas',
      'Reparación de circuitos',
      'Mantenimiento de sistemas eléctricos'
    ],
    'Fontanería': [
      'Reparación de tuberías',
      'Instalación de sanitarios',
      'Desatascos y limpieza de drenajes'
    ],
    'Pintura': [
      'Pintura de interiores',
      'Pintura de exteriores',
      'Restauración de superficies'
    ],
    'Jardinería': [
      'Diseño de jardines',
      'Mantenimiento de césped',
      'Poda de árboles y arbustos'
    ],
  };

  final List<String> _districts = [
    'Arequipa (Cercado)',
    'Alto Selva Alegre',
    'Cayma',
    'Cerro Colorado',
    'Jacobo Hunter',
    'José Luis Bustamante y Rivero',
    'Mariano Melgar',
    'Miraflores',
    'Paucarpata',
    'Sachaca',
    'Socabaya',
    'Yanahuara',
    'Tiabaya',
    'Characato',
    'Mollebaya',
    'Quequeña',
    'Sabandía',
    'Yarabamba',
    'Chiguata',
    'San Juan de Tarucani',
    'Santa Rita de Siguas',
    'Vítor',
    'Yura',
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectTimeSlot() async {
    List<String> daysOfWeek = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar Franjas Horarias'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: daysOfWeek.map((day) {
              return CheckboxListTile(
                title: Text(day),
                value: _selectedDays.contains(day),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedDays.add(day);
                    } else {
                      _selectedDays.remove(day);
                      _selectedTimes.remove(day);
                    }
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (_selectedDays.isNotEmpty) {
                  _showTimePicker(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF3F60A0)),
              ),
              child: Text(
                'Seleccionar Horas',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTimePicker(BuildContext context) async {
    for (String day in _selectedDays) {
      bool addMoreTimes = true;
      while (addMoreTimes) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            _selectedTimes.putIfAbsent(day, () => []).add(pickedTime);
          });
        }

        // Preguntar si se desea agregar otra franja horaria para el mismo día
        addMoreTimes = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Agregar otra franja horaria?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Sí'),
                ),
              ],
            );
          },
        ) ?? false;
      }
    }
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFFF5F5F5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF6286CB)),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      filled: true,
      fillColor: Color(0xFFF5F5F5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text('Agregar Servicio'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Elegir de la galería'),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_camera),
                              title: Text('Tomar una foto'),
                              onTap: () {
                                Navigator.pop(context);
                                _takePhoto();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _image == null
                        ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Nota: Puedes subir imágenes en formato 'jpg', 'png' y 'jpeg'",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _serviceNameController,
                decoration: _buildInputDecoration('Nombre del servicio'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el nombre del servicio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: _buildInputDecoration('Descripción'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                    _selectedSubCategory = null; // Reset subcategory when category changes
                  });
                },
                items: _categories.keys.map((category) {
                  return DropdownMenuItem(
                    child: Text(category),
                    value: category,
                  );
                }).toList(),
                decoration: _buildInputDecoration('Categoría'),
                validator: (value) => value == null ? 'Por favor selecciona una categoría' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedSubCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedSubCategory = newValue;
                  });
                },
                items: _selectedCategory == null
                    ? []
                    : _categories[_selectedCategory]!.map((subcategory) {
                  return DropdownMenuItem(
                    child: Text(subcategory),
                    value: subcategory,
                  );
                }).toList(),
                decoration: _buildInputDecoration('Subcategoría'),
                validator: (value) => value == null ? 'Por favor selecciona una subcategoría' : null,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
                items: _districts.map((district) {
                  return DropdownMenuItem(
                    child: Text(district),
                    value: district,
                  );
                }).toList(),
                decoration: _buildInputDecoration('Distrito'),
                validator: (value) => value == null ? 'Por favor selecciona un distrito' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: _buildInputDecoration('Precio'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _chargeMode,
                onChanged: (newValue) {
                  setState(() {
                    _chargeMode = newValue;
                  });
                },
                items: ['Por hora', 'Por metro cuadrado'].map((mode) {
                  return DropdownMenuItem(
                    child: Text(mode),
                    value: mode,
                  );
                }).toList(),
                decoration: _buildInputDecoration('Modalidad de Cobro'),
                validator: (value) => value == null ? 'Por favor selecciona una modalidad de cobro' : null,
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Estado'),
                trailing: Switch(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Pago Anticipado'),
                trailing: Switch(
                  value: _isPrepaid,
                  onChanged: (value) {
                    setState(() {
                      _isPrepaid = value;
                      if (!_isPrepaid) {
                        _prepaidPercentageController.clear();
                      }
                    });
                  },
                ),
              ),
              if (_isPrepaid)
                TextFormField(
                  controller: _prepaidPercentageController,
                  decoration: _buildInputDecoration('Porcentaje de Pago Anticipado'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (_isPrepaid && value!.isEmpty) {
                      return 'Por favor ingresa el porcentaje de pago anticipado';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _selectTimeSlot,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF3F60A0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'Seleccionar Franjas Horarias',
                    style: TextStyle(
                      fontFamily: 'Mont',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ..._selectedDays.map((day) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...?_selectedTimes[day]?.map((time) {
                      return Text('${time.format(context)}');
                    }).toList(),
                    Divider(),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Procesar la información del formulario
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF3F60A0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'Guardar Servicio',
                    style: TextStyle(
                      fontFamily: 'Mont',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
