import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../common_widgets/CustomButton.dart';
import '../../../../common_widgets/CustomMessageDialog.dart';
import '../../../../common_widgets/CustomTextField.dart';

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  String? _selectedSubCategory;
  List<String> _selectedDistricts = [];
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
            CustomButton(
              text: 'Seleccionar Horas',
              onPressed: () {
                Navigator.of(context).pop();
                if (_selectedDays.isNotEmpty) {
                  _showTimePicker(context);
                }
              },
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

  Future<void> _selectDistricts(BuildContext context) async {
    List<String> selected = List.from(_selectedDistricts);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccionar Distritos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _districts.map((district) {
                return CheckboxListTile(
                  title: Text(district),
                  value: selected.contains(district),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selected.add(district);
                      } else {
                        selected.remove(district);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            CustomButton(
              text: 'Aceptar',
              onPressed: () {
                setState(() {
                  _selectedDistricts = selected;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCustomMessageDialog(BuildContext context, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomMessageDialog(
          message: message,
          onConfirm: onConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          'Agregar Servicio',
          style: TextStyle(
            fontFamily: 'Mont',
            fontWeight: FontWeight.bold,
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
              CustomTextField(
                controller: _serviceNameController,
                labelText: 'Nombre del Servicio',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del servicio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                        _selectedSubCategory = null;
                      });
                    },
                    items: _categories.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (_selectedCategory != null)
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Subcategoría',
                    border: OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedSubCategory,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubCategory = newValue;
                        });
                      },
                      items: _categories[_selectedCategory]!.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _descriptionController,
                labelText: 'Descripción del Servicio',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _priceController,
                labelText: 'Precio',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Modo de Cobro',
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _chargeMode,
                    isDense: true,
                    onChanged: (String? newValue) {
                      setState(() {
                        _chargeMode = newValue;
                      });
                    },
                    items: ['Por Hora', 'Por Día', 'Por Trabajo'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text('Servicio Prepagado'),
                value: _isPrepaid,
                onChanged: (value) {
                  setState(() {
                    _isPrepaid = value;
                  });
                },
              ),
              if (_isPrepaid)
                CustomTextField(
                  controller: _prepaidPercentageController,
                  labelText: 'Porcentaje de prepago',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_isPrepaid && (value == null || value.isEmpty)) {
                      return 'Por favor ingresa el porcentaje de prepago';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Seleccionar Franjas Horarias',
                onPressed: () {
                  _selectTimeSlot();
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Seleccionar Distritos',
                onPressed: () {
                  _selectDistricts(context);
                },
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: Text('Activo'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Guardar Servicio',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showCustomMessageDialog(
                      context,
                      '¿Estás seguro de que quieres guardar el servicio?',
                          () {
                        // Aquí puedes manejar la lógica de guardar el servicio
                        Navigator.of(context).pop(); // Cerrar el diálogo
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

