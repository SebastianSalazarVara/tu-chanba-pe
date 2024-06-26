import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool _isOptionSelected1 = false;
  bool _isOptionSelected2 = false;
  bool _isOptionSelected3 = false;
  bool _isOptionSelected4 = false;
  bool _isOptionSelected5 = false;
  bool _isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  // Aquí puedes añadir la imagen del usuario
                  // backgroundImage: AssetImage('ruta_a_la_imagen'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Color(0xFF0158C8),
                    child: Icon(Icons.edit, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('cliente01', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 20)),
            Text('cliente@gmail.com', style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),
            _buildProfileOption(Icons.favorite, 'Servicios Favoritos', _isOptionSelected1, () {
              setState(() {
                _isOptionSelected1 = !_isOptionSelected1;
              });
              _resetSelectionAfterDelay();
              // Implementar lógica para 'Servicios Favoritos'
            }),
            _buildProfileOption(Icons.favorite_border, 'Proveedores Favoritos', _isOptionSelected2, () {
              setState(() {
                _isOptionSelected2 = !_isOptionSelected2;
              });
              _resetSelectionAfterDelay();
              // Implementar lógica para 'Proveedores Favoritos'
            }),
            _buildProfileOption(Icons.rate_review, 'Mis reseñas', _isOptionSelected3, () {
              setState(() {
                _isOptionSelected3 = !_isOptionSelected3;
              });
              _resetSelectionAfterDelay();
              // Implementar lógica para 'Mis reseñas'
            }),
            _buildProfileOption(Icons.lock, 'Cambiar Contraseña', _isOptionSelected4, () {
              setState(() {
                _isOptionSelected4 = !_isOptionSelected4;
              });
              _resetSelectionAfterDelay();
              // Implementar lógica para 'Cambiar Contraseña'
            }),
            _buildProfileOption(Icons.logout, 'Cerrar Sesión', _isOptionSelected5, () {
              setState(() {
                _isOptionSelected5 = true;
                _isLoggingOut = true;
              });
              _resetSelectionAfterDelay();
              _showLogoutConfirmationDialog();
            }, _isLoggingOut),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, bool isSelected, VoidCallback onTap, [bool isLoggingOut = false]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isLoggingOut ? Colors.grey[400] : (isSelected ? Colors.grey[300] : null),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFDFDFDF),
              child: Icon(icon, color: Color(0xFF888888)),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(title, style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16)),
            ),
            Icon(Icons.chevron_right, color: Color(0xFF888888)),
          ],
        ),
      ),
    );
  }

  void _resetSelectionAfterDelay() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isOptionSelected1 = false;
        _isOptionSelected2 = false;
        _isOptionSelected3 = false;
        _isOptionSelected4 = false;
        _isOptionSelected5 = false;
        _isLoggingOut = false;
      });
    });
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              '¿Estás seguro/a de que deseas cerrar sesión?',
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
                  Navigator.of(context).pushReplacementNamed('/login'); // Navegar a la página de login
                },
                child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3F60A0)),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        );
      },
    ).then((_) {
      setState(() {
        _isLoggingOut = false;
      });
    });
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => PerfilPage(),
      '/login': (context) => LoginPage(), // Asumiendo que LoginPage está definida en login_page.dart
    },
  ));
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Text('Contenido de la página de inicio de sesión'),
      ),
    );
  }
}
