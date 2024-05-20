import 'package:flutter/material.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _isPressed = false;
  bool _isLoginHover = false;
  bool _isAccountHover = false;

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
        title: Text('Recuperar Contraseña', style: TextStyle(fontFamily: 'Mont')),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Introduzca su dirección de correo electrónico para recibir un mensaje y restablecer su contraseña.',
                    style: TextStyle(fontFamily: 'Mont'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFFF5F5F5)), // Color del borde predeterminado
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xFF6286CB)), // Color del borde cuando está enfocado
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    style: TextStyle(fontFamily: 'Mont'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        _isPressed = true;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isPressed = false;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _isPressed = false;
                      });
                    },
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Se ha enviado el correo de recuperación')),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isPressed ? Color(0xFF2E4A7D) : Color(0xFF3F60A0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Enviar',
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
                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8), // Ajustar el padding
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
                      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8), // Ajustar el padding
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
    );
  }
}










