import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// Controlador para el campo de contraseña
TextEditingController _passwordController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _termsChecked = false;
  bool _isLoginHover = false;
  bool _isAccountHover = false;

  // Variables para la validación de la contraseña
  bool _isLengthValid = false;
  bool _hasUpperCase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  void _validatePassword(String value) {
    setState(() {
      _isLengthValid = value.length >= 8;
      _hasUpperCase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_+/*-]'));
    });
  }

  void _register() {
    if (_formKey.currentState!.validate() && _termsChecked) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registro exitoso"),
            content: Text("¡Tu cuenta ha sido creada con éxito!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Registrarse'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/register_image.png', height: 100),
                SizedBox(height: 20),
                Text('Crea tu cuenta para una mejor experiencia', textAlign: TextAlign.center),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Tipo de Usuario',
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
                  items: [
                    DropdownMenuItem(child: Text('Proveedor'), value: 'Proveedor'),
                    DropdownMenuItem(child: Text('Cliente'), value: 'Cliente'),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) _formKey.currentState!.validate();
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nombres',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                        return 'El nombre solo puede contener letras y espacios';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) _formKey.currentState!.validate();
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tus apellidos';
                      } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                        return 'El apellido solo puede contener letras y espacios';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) _formKey.currentState!.validate();
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dirección de correo',
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
                    validator: (value) {
                      if (value == null || !EmailValidator.validate(value)) {
                        return 'Por favor ingresa un correo válido';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                Focus(
                  onFocusChange: (hasFocus) {
                    if (!hasFocus) _formKey.currentState!.validate();
                  },
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Número de Contacto',
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
                        return 'Por favor ingresa tu número de contacto';
                      } else if (!RegExp(r"^[0-9]{1,9}$").hasMatch(value)) {
                        return 'El número de contacto debe contener solo números y un máximo de 9 dígitos';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF6286CB)),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                  obscureText: !_isPasswordVisible,
                  style: TextStyle(fontFamily: 'Mont'),
                  onChanged: _validatePassword,
                ),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPasswordCriteriaRow(
                      'Mínimo 8 caracteres',
                      _isLengthValid,
                    ),
                    _buildPasswordCriteriaRow(
                      'Uso de mayúsculas',
                      _hasUpperCase,
                    ),
                    _buildPasswordCriteriaRow(
                      'Uso de números',
                      _hasNumber,
                    ),
                    _buildPasswordCriteriaRow(
                      'Uso de símbolos',
                      _hasSpecialChar,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                    text: TextSpan(
                      text: 'Acepto los ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Términos de servicio',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: ' y la '),
                        TextSpan(
                          text: 'Política de privacidad',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  value: _termsChecked,
                  onChanged: (newValue) {
                    setState(() {
                      _termsChecked = newValue!;
                    });
                  },
                ),
                GestureDetector(
                  onTap: _register,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3F60A0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                        fontFamily: 'Mont',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _isAccountHover = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _isAccountHover = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8),
                          color: Colors.transparent,
                          child: Text(
                            '¿Ya tienes cuenta? ',
                            style: TextStyle(
                              color: _isAccountHover ? Color(0xFFFF914D) : Colors.black,
                              fontFamily: 'Mont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _isLoginHover = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _isLoginHover = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8),
                          color: Colors.transparent,
                          child: Text(
                            'Iniciar sesión',
                            style: TextStyle(
                              color: _isLoginHover ? Color(0xFFFF914D) : Colors.blue,
                              fontFamily: 'Mont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
          ),
        ),
      ],
    );
  }
}