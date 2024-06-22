import 'package:flutter/material.dart';
import 'home_page_cliente.dart'; // Importa la HomePageCliente que contiene la navegación por pestañas
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../url.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;

  ChangePasswordPage({required this.email});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _oldPasswordFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _isLengthValid = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();

    // Adding listeners to focus nodes to validate on losing focus
    _oldPasswordFocusNode.addListener(() {
      if (!_oldPasswordFocusNode.hasFocus) {
        _formKey.currentState!.validate();
      }
    });

    _newPasswordFocusNode.addListener(() {
      if (!_newPasswordFocusNode.hasFocus) {
        _formKey.currentState!.validate();
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        _formKey.currentState!.validate();
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _isLengthValid = value.length >= 8;
      _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_+/*-]'));
    });
  }

  void _submitForm() {
    setState(() {
      _autoValidate = true;
    });

    if (_formKey.currentState!.validate()) {
      _showPasswordChangeConfirmationDialog();
    }
  }

  void _showPasswordChangeConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              '¿Estás seguro/a de que deseas proceder con estos cambios?',
              style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                },
                child: Text('Cancelar', style: TextStyle(color: Colors.black)),
                style: TextButton.styleFrom(
                  side: BorderSide(color: Color(0xFF3F60A0)),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageCliente(initialIndex: 2, user: {},), // Navega a HomePageCliente con el índice 2 (Perfil)
                    ),
                        (Route<dynamic> route) => false, // Elimina todas las rutas anteriores
                  );
                },
                child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3F60A0)),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  String? _validateOldPassword(String? value) {
    
    if (value != '123456') {
      return 'Contraseña incorrecta';
    }
    return null;
  }

//ESTA ERA LA FUNCIONALIDAD PARA CAMBIAR LA CONTRASEÑA OSEA QUE DE UNA VEZ
//QUE SE ENVIE LA CONTRASEÑA ANTIGUA Y LA NUEVA A LA BASE DE DATOS Y QUE ESTE BOTE VERDADERO O FALSO
//El email o correo esta en el widget.email
  Future<bool> _changePassword(String mail, String oldPassword, String newPassword) async {
    var url1= ruta+'/sesion';
    final uri = Uri.parse(url1);
    final client = http.Client();
    try{
      final response = await client.put(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': mail,
          'password_old': oldPassword,
          'password_new': newPassword,
        }),
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body);
        bool apiResult =data.toLowerCase() == 'true';
        return apiResult;
      }else{
        return false;
      }
    }
    catch(e){
      return false;
    }
    finally{
      client.close();
    }
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu nueva contraseña';
    } else if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra mayúscula';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'La contraseña debe tener al menos un número';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_+/*-]').hasMatch(value)) {
      return 'La contraseña debe tener al menos un carácter especial';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _newPasswordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña', style: TextStyle(color: Colors.white, fontFamily: 'Mont-Bold')),
        backgroundColor: Color(0xFF6286CB),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            children: [
              Text(
                'Tu nueva contraseña debe ser diferente a la contraseña utilizada anteriormente',
                style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 16),
              _buildPasswordField('Contraseña anterior', _oldPasswordController, !_isPasswordVisible, _validateOldPassword, _oldPasswordFocusNode),
              SizedBox(height: 16),
              _buildPasswordField('Nueva contraseña', _newPasswordController, !_isPasswordVisible, _validateNewPassword, _newPasswordFocusNode, onChanged: _validatePassword),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPasswordCriteriaRow('Mínimo 8 caracteres', _isLengthValid),
                  _buildPasswordCriteriaRow('Uso de mayúsculas', _hasUpperCase),
                  _buildPasswordCriteriaRow('Uso de números', _hasNumber),
                  _buildPasswordCriteriaRow('Uso de símbolos', _hasSpecialChar),
                ],
              ),
              SizedBox(height: 16),
              _buildPasswordField('Vuelve a ingresar la contraseña', _confirmPasswordController, !_isPasswordVisible, _validateConfirmPassword, _confirmPasswordFocusNode),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Confirmar', style: TextStyle(fontFamily: 'Mont-Bold', color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3F60A0), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscureText, String? Function(String?)? validator, FocusNode focusNode, {Function(String)? onChanged}) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFF5F5F5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF304FFE)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFF5F5F5)),
            ),
            child: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildPasswordCriteriaRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle_outline : Icons.highlight_off,
          color: isValid ? Colors.green : Colors.red,
          size: 18,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontFamily: 'Mont-Regular',
          ),
        ),
      ],
    );
  }
}
