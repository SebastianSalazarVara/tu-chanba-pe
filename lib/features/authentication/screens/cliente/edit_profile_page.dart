import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _contactNumberController;
  late TextEditingController _addressController;

  String? _selectedDepartment;
  String? _selectedProvince;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user['name']);
    _surnameController = TextEditingController(text: widget.user['surname']);
    _emailController = TextEditingController(text: widget.user['email']);
    _contactNumberController = TextEditingController(text: widget.user['contactNumber']);
    _addressController = TextEditingController(text: widget.user['address']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil', style: TextStyle(fontFamily: 'Mont-Bold')),
        backgroundColor: Color(0xFF6286CB),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : (widget.user['profileImage'] != null
                          ? NetworkImage(widget.user['profileImage'])
                          : AssetImage('assets/default_profile.png')) as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Color(0xFF0158C8),
                        child: Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildTextField(_nameController, 'Nombres'),
              _buildTextField(_surnameController, 'Apellidos'),
              _buildTextField(_emailController, 'Dirección de correo'),
              _buildTextField(_contactNumberController, 'Número de Contacto'),
              _buildDropdown('Departamento', _selectedDepartment, (String? newValue) {
                setState(() {
                  _selectedDepartment = newValue;
                  // Update _selectedProvince based on selected department
                });
              }),
              _buildDropdown('Provincia', _selectedProvince, (String? newValue) {
                setState(() {
                  _selectedProvince = newValue;
                });
              }),
              _buildTextField(_addressController, 'Dirección del Contacto'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                },
                child: Text('Guardar cambios', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6286CB),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String labelText, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        value: value,
        onChanged: onChanged,
        items: <String>['Option 1', 'Option 2', 'Option 3'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}