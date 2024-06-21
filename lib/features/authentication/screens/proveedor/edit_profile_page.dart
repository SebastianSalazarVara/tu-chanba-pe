import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common_widgets/CustomButton.dart';
import '../../../../common_widgets/CustomDropdown.dart';
import '../../../../common_widgets/CustomTextField.dart';
import '../../../../common_widgets/TopBar.dart';
import '../../../../common_widgets/CustomMessageDialog.dart';

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
  late TextEditingController _whyChooseMeController;
  late TextEditingController _aboutMeController;

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
    _whyChooseMeController = TextEditingController(text: widget.user['whyChooseMe'] ?? '');
    _aboutMeController = TextEditingController(text: widget.user['aboutMe'] ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    _whyChooseMeController.dispose();
    _aboutMeController.dispose();
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

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomMessageDialog(
          message: '¿Está seguro que desea guardar los cambios?',
          onConfirm: _saveProfile,
        );
      },
    );
  }

  void _saveProfile() {
    print("Profile saved!");
    // Aquí puedes implementar la lógica para guardar los datos en la base de datos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Editar Perfil',
        showBackButton: true,
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
              CustomTextField(
                labelText: 'Nombres',
                controller: _nameController,
              ),
              SizedBox(height: 8),
              CustomTextField(
                labelText: 'Apellidos',
                controller: _surnameController,
              ),
              SizedBox(height: 8),
              CustomTextField(
                labelText: 'Dirección de correo',
                controller: _emailController,
              ),
              SizedBox(height: 8),
              CustomTextField(
                labelText: 'Número de Contacto',
                controller: _contactNumberController,
              ),
              SizedBox(height: 8),
              CustomDropdown(
                labelText: 'Departamento',
                value: _selectedDepartment,
                items: ['Option 1', 'Option 2', 'Option 3']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDepartment = newValue;
                  });
                },
              ),
              SizedBox(height: 8),
              CustomDropdown(
                labelText: 'Provincia',
                value: _selectedProvince,
                items: ['Option 1', 'Option 2', 'Option 3']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProvince = newValue;
                  });
                },
              ),
              SizedBox(height: 8),
              CustomTextField(
                labelText: 'Dirección del Contacto',
                controller: _addressController,
              ),
              SizedBox(height: 8),
              CustomTextField(
                labelText: '¿Por qué elegirme?',
                controller: _whyChooseMeController,
                maxLines: 3,
              ),
              SizedBox(height: 8),
              CustomTextField(
                labelText: 'Sobre ti',
                controller: _aboutMeController,
                maxLines: 3,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Guardar cambios',
                onPressed: _showConfirmationDialog,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


