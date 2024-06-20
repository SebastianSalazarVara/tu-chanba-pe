import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../common_widgets/CustomButton.dart';
import '../../../common_widgets/CustomCheckbox.dart';
import '../../../common_widgets/CustomDropdown.dart';
import '../../../common_widgets/CustomTextField.dart';
import '../../../common_widgets/PasswordValidationField.dart';
import '../../../common_widgets/RichTextLink.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _termsChecked = false;
  String? _selectedUserType;
  String? _email;
  String? _nombres;
  String? _apellidos;
  String? _contact;

  // Mueve el controlador dentro de la clase State
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  void dispose() {
    // Asegúrate de liberar los controladores cuando no sean necesarios
    _passwordController.dispose();
    _nombresController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<Database> _initializeDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(email TEXT PRIMARY KEY, nombres TEXT, apellidos TEXT, userType TEXT, contact TEXT, password TEXT, profilePhoto TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> _registerUser(String email, String nombres, String apellidos, String userType, String contact, String password) async {
    final db = await _initializeDatabase();

    try {
      await db.insert(
        'users',
        {'email': email, 'nombres': nombres, 'apellidos': apellidos, 'userType': userType, 'contact': contact, 'password': password, 'profilePhoto': ''},
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } catch (e) {
      throw Exception('El correo ya está registrado.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: _formKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate() && _termsChecked) {
      _formKey.currentState!.save();

      // Asigna los valores de los controladores a las variables de instancia
      _nombres = _nombresController.text;
      _apellidos = _apellidosController.text;
      _email = _emailController.text;
      _contact = _contactController.text;

      try {
        await _registerUser(
          _email!,
          _nombres!,
          _apellidos!,
          _selectedUserType!,
          _contact!,
          _passwordController.text,
        );

        _showDialog("Registro exitoso", "¡Tu cuenta ha sido creada con éxito!");
      } catch (e) {
        _showSnackBar(e.toString());
      }
    }
  }

  String? _validateUserType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor elige un tipo de usuario';
    }
    return null;
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
                CustomDropdown(
                  labelText: 'Tipo de Usuario',
                  value: _selectedUserType,
                  items: [
                    DropdownMenuItem(child: Text('Proveedor'), value: 'Proveedor'),
                    DropdownMenuItem(child: Text('Cliente'), value: 'Cliente'),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUserType = newValue;
                    });
                  },
                  validator: _validateUserType,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Nombres',
                  controller: _nombresController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                      return 'El nombre solo puede contener letras y espacios';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Apellidos',
                  controller: _apellidosController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tus apellidos';
                    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                      return 'El apellido solo puede contener letras y espacios';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Dirección de correo',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !EmailValidator.validate(value)) {
                      return 'Por favor ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Número de Contacto',
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu número de contacto';
                    } else if (!RegExp(r"^[0-9]{1,9}$").hasMatch(value)) {
                      return 'El número de contacto debe contener solo números y un máximo de 9 dígitos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        PasswordValidationField(
                          controller: _passwordController,
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (_passwordController.text.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                FormField<bool>(
                  builder: (FormFieldState<bool> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomCheckbox(
                          value: _termsChecked,
                          onChanged: (newValue) {
                            setState(() {
                              _termsChecked = newValue!;
                              state.didChange(newValue);
                            });
                          },
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
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                      ],
                    );
                  },
                  validator: (value) {
                    if (!_termsChecked) {
                      return 'Por favor acepta los términos y condiciones';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Registrarse',
                  onPressed: _register,
                ),
                SizedBox(height: 10),
                RichTextLink(
                  normalText: '¿Ya tienes cuenta? ',
                  linkText: 'Iniciar sesión',
                  onLinkTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

