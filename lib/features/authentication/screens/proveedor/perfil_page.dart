import 'package:flutter/material.dart';
import 'package:tuchanbape/features/authentication/screens/login_page.dart';
import 'edit_profile_page.dart';  // Importa EditProfilePage

import 'change_password_page.dart';
import 'billing_info_page.dart';  // Página de información de cobro
import 'services_page.dart';      // Página de servicios

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
  bool _isLoggingOut = false;
  bool _isAvailable = true;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.height < 600) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSmallScreenErrorDialog();
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
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
            _buildAvailabilityOption(),
            _buildProfileOption(Icons.build, 'Servicios', _isOptionSelected1, () {
              setState(() {
                _isOptionSelected1 = !_isOptionSelected1;
              });
              _resetSelectionAfterDelay();
              _navigateToServicesPage();
            }),
            _buildProfileOption(Icons.lock, 'Cambiar contraseña', _isOptionSelected2, () {
              setState(() {
                _isOptionSelected2 = !_isOptionSelected2;
              });
              _resetSelectionAfterDelay();
              _navigateToChangePasswordPage();
            }),
            _buildProfileOption(Icons.credit_card, 'Información de Cobro', _isOptionSelected3, () {
              setState(() {
                _isOptionSelected3 = !_isOptionSelected3;
              });
              _resetSelectionAfterDelay();
              _navigateToBillingInfoPage();
            }),
            _buildProfileOption(Icons.logout, 'Cerrar Sesión', _isOptionSelected4, () {
              setState(() {
                _isOptionSelected4 = true;
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

  Widget _buildAvailabilityOption() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAvailable ? 'Estado disponible' : 'Estado no disponible',
                  style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
                ),
                Text(
                  _isAvailable ? 'Estás en línea' : 'No estás en línea',
                  style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: _isAvailable,
            onChanged: (value) {
              setState(() {
                _isAvailable = value;
              });
            },
            activeColor: Colors.green,
          ),
        ],
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

  void _showSmallScreenErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Pantalla demasiado pequeña',
              style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          content: Text(
            'Esta aplicación requiere una pantalla más grande para funcionar correctamente.',
            style: TextStyle(fontFamily: 'Mont-Regular', fontSize: 14),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Aceptar', style: TextStyle(color: Colors.black)),
              style: TextButton.styleFrom(
                side: BorderSide(color: Color(0xFF3F60A0)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToServicesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ServicesPage()),
    );
  }

  void _navigateToBillingInfoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillingInfoPage()),
    );
  }

  void _navigateToChangePasswordPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
    );
  }
}
