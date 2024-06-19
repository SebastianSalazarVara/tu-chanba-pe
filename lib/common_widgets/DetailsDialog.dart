import 'package:flutter/material.dart';

import '../../../../common_widgets/CustomButton.dart';
import '../../../../common_widgets/CustomTextField.dart';
import '../../../../common_widgets/CustomDropdown.dart';

class DetailsDialog extends StatefulWidget {
  final String name;
  final String entity;
  final bool isNew;

  const DetailsDialog({
    Key? key,
    required this.name,
    required this.entity,
    this.isNew = false,
  }) : super(key: key);

  @override
  _DetailsDialogState createState() => _DetailsDialogState();
}

class _DetailsDialogState extends State<DetailsDialog> {
  final TextEditingController _nameController = TextEditingController();
  String _status = 'Activo';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
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
                    widget.isNew ? 'Agregar ${widget.entity}' : 'Editar ${widget.entity}',
                    style: TextStyle(
                      fontFamily: 'Mont-Bold',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  if (!widget.isNew)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Implementa la lógica para eliminar la entidad
                      },
                    ),
                ],
              ),
              SizedBox(height: 16),
              CustomTextField(
                labelText: 'Nombre',
                controller: _nameController,
              ),
              SizedBox(height: 16),
              CustomDropdown(
                labelText: 'Estado',
                value: _status,
                items: [
                  DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                  DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
                ],
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              CustomButton(
                text: 'Guardar',
                onPressed: () {
                  // Implementa la lógica de guardar los cambios
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
