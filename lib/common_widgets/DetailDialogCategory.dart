import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../common_widgets/CustomButton.dart';
import '../../../../common_widgets/CustomDropdown.dart';
import '../../../../common_widgets/CustomTextField.dart';
import '../../../../common_widgets/CustomMessageDialog.dart';

class DetailDialogCategory extends StatefulWidget {
  final String title;
  final String name;
  final String image;
  final VoidCallback onDelete;
  final VoidCallback onSave;

  const DetailDialogCategory({
    Key? key,
    required this.title,
    required this.name,
    required this.image,
    required this.onDelete,
    required this.onSave,
  }) : super(key: key);

  @override
  _DetailDialogCategoryState createState() => _DetailDialogCategoryState();
}

class _DetailDialogCategoryState extends State<DetailDialogCategory> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Mont-Bold',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: widget.onDelete,
                  ),
                ],
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage(widget.image) as ImageProvider,
                  radius: 40,
                ),
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: 'Nombre',
                controller: _nameController,
              ),
              SizedBox(height: 16),
              CustomDropdown(
                labelText: 'Estado',
                value: 'Activo',
                items: [
                  DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                  DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: 'Descripción',
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
              SizedBox(height: 16),
              CustomButton(
                text: 'Guardar',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CustomMessageDialog(
                      message: '¿Estás seguro/a de que deseas guardar los cambios?',
                      onConfirm: () {
                        // Llama a la función de guardado pasada como parámetro
                        widget.onSave();
                        Navigator.of(context).pop(); // Cierra el CustomMessageDialog
                        Navigator.of(context).pop(); // Cierra el DetailDialogCategory
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
