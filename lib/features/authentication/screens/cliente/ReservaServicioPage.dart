import 'package:flutter/material.dart';

class ReservaServicioPage extends StatefulWidget {
  @override
  _ReservaServicioPageState createState() => _ReservaServicioPageState();
}

class _ReservaServicioPageState extends State<ReservaServicioPage> {
  int _serviceQuantity = 1;
  String _userAddress = "Dirección por defecto del usuario";
  String _description = "";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );
      if (pickedTime != null && pickedTime != _selectedTime) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });
      }
    }
  }

  double _calculateTotalPrice() {
    // Precio por hora en soles
    const double pricePerHour = 150.0;
    // Precio por servicio considerando una duración de 30 minutos
    const double pricePerService = pricePerHour / 2;
    return _serviceQuantity * pricePerService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar Servicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Servicio: Armarios y vestidores a medida', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Row(
              children: [
                Text('Cantidad: '),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_serviceQuantity > 1) _serviceQuantity--;
                    });
                  },
                ),
                Text('$_serviceQuantity'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _serviceQuantity++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Duración: 30 min', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Dirección',
                hintText: 'Ingrese su dirección',
              ),
              controller: TextEditingController(text: _userAddress),
              onChanged: (value) {
                setState(() {
                  _userAddress = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingrese una descripción',
              ),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text('Fecha y Hora de Inicio', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selectDateTime(context),
              child: Text('Seleccionar Fecha y Hora'),
            ),
            SizedBox(height: 8),
            Text('Fecha seleccionada: ${_selectedDate.toLocal()}'.split(' ')[0]),
            Text('Hora seleccionada: ${_selectedTime.format(context)}'),
            SizedBox(height: 16),
            Text('Detalles del Precio', style: TextStyle(fontSize: 16)),
            Text('Cantidad: $_serviceQuantity'),
            Text('Precio total: S/ ${_calculateTotalPrice().toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para confirmar la reserva
                },
                child: Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
