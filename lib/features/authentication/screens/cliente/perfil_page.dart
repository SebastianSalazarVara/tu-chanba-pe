import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import '../login_page.dart';
import 'change_password_page.dart';

class PerfilPage extends StatefulWidget {
  final Map<String, dynamic> user;

  PerfilPage({required this.user});

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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage(user: widget.user)),
                );
              },
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: widget.user['profileImage'] != null
                        ? NetworkImage(widget.user['profileImage'])
                        : AssetImage('assets/default_profile.png') as ImageProvider,
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
            ),
            SizedBox(height: 10),
            Text(widget.user['name'], style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 20)),
            Text(widget.user['email'], style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),
            // Eliminar opciones de Servicios Favoritos, Proveedores Favoritos y Mis reseñas
            _buildProfileOption(Icons.lock, 'Cambiar Contraseña', _isOptionSelected4, () {
              setState(() {
                _isOptionSelected4 = !_isOptionSelected4;
              });
              _resetSelectionAfterDelay();
              _navigateToChangePasswordPage();
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
    Future.delayed(Duration(milliseconds: 200), () {
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

  void _navigateToChangePasswordPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage(email: widget.user['email'])));
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
                  setState(() {
                    _isLoggingOut = false;
                  });
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
                  _logout(); // Ejecutar la función de cierre de sesión
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

  void _logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
