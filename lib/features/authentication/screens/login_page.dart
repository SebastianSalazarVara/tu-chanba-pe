import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
import 'proveedor/home_page_proveedor.dart'; // Página de inicio para proveedores
import 'cliente/home_page_cliente.dart'; // Página de inicio para clientes

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoginPressed = false;
  bool _isForgotPasswordHover = false;
  bool _isRegisterHover = false;

  // Controladores para los campos de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variables para controlar la visibilidad de la contraseña y los mensajes de error
  bool _isPasswordVisible = false;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isCredentialsValid = true;

  @override
  void dispose() {
    // Limpiar los controladores cuando se destruye el widget
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() {
      _isEmailValid = _emailController.text.isNotEmpty;
      _isPasswordValid = _passwordController.text.isNotEmpty;
      _isCredentialsValid = true;

      if (_isEmailValid && _isPasswordValid) {
        if (_emailController.text == 'proveedor@gmail.com' && _passwordController.text == '123456') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePageProveedor()),
          );
        } else if (_emailController.text == 'cliente@gmail.com' && _passwordController.text == '123456') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePageCliente()),
          );
        } else {
          _isCredentialsValid = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Text(
                '¡Bienvenido a Chamba PE!',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mont-Bold',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Container(
                width: 300,
                child: Image.asset('assets/images/login_image.png'),
              ),
              SizedBox(height: 40),
              Container(
                width: 350,
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Ingresar Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFFF5F5F5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Color(0xFF6286CB)),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        errorText: _isEmailValid ? null : 'Este campo es obligatorio',
                      ),
                      style: TextStyle(fontFamily: 'Mont'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Ingresar Contraseña',
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
                        errorText: _isPasswordValid ? null : 'Este campo es obligatorio',
                      ),
                      obscureText: !_isPasswordVisible,
                      style: TextStyle(fontFamily: 'Mont'),
                    ),
                    SizedBox(height: 10),
                    if (!_isCredentialsValid)
                      Text(
                        'Correo o contraseña incorrectos',
                        style: TextStyle(color: Colors.red, fontFamily: 'Mont'),
                      ),
                    SizedBox(height: 10),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _isForgotPasswordHover = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _isForgotPasswordHover = false;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                          );
                        },
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                            color: _isForgotPasswordHover ? Color(0xFFFF914D) : Colors.blue,
                            fontFamily: 'Mont',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          _isLoginPressed = true;
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          _isLoginPressed = false;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _isLoginPressed = false;
                        });
                      },
                      onTap: _login,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isLoginPressed ? Color(0xFF2E4A7D) : Color(0xFF3F60A0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontFamily: 'Mont',
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      '¿No tienes cuenta? ',
                      style: TextStyle(color: Colors.black, fontFamily: 'Mont'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isRegisterHover = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isRegisterHover = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Regístrate ahora',
                        style: TextStyle(
                          color: _isRegisterHover ? Color(0xFFFF914D) : Colors.blue,
                          fontFamily: 'Mont',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}