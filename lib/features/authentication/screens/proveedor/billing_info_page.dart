import 'package:flutter/material.dart';

class BillingInfoPage extends StatefulWidget {
  @override
  _BillingInfoPageState createState() => _BillingInfoPageState();
}

class _BillingInfoPageState extends State<BillingInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountNumberController = TextEditingController();

  void _confirm() {
    if (_formKey.currentState!.validate()) {
      // Implementar la lógica de confirmación aquí
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmación exitosa"),
            content: Text("¡Su número de cuenta bancaria ha sido guardado!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Otras acciones después de la confirmación
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            SizedBox(width: 10),
            Text('Información de Cobro', style: TextStyle(fontFamily: 'Mont-Bold', color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Por favor, proporcione su número de cuenta bancaria',
                  style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                    labelText: 'Número de Cuenta Bancaria',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF6286CB)),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su número de cuenta bancaria';
                    } else if (!RegExp(r"^[0-9]{10,20}$").hasMatch(value)) {
                      return 'El número de cuenta debe contener entre 10 y 20 dígitos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _confirm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3F60A0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      'Confirmar',
                      style: TextStyle(
                        fontFamily: 'Mont-Bold',
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BillingInfoPage(),  
  ));
}
