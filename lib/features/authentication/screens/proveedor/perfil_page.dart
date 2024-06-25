import 'package:flutter/material.dart';
import 'package:tuchanbape/features/authentication/screens/login_page.dart';
import '../../../../common_widgets/LogoutConfirmationDialog.dart';
import '../../../../common_widgets/MenuItem.dart';
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

  @override
  Widget build(BuildContext context) {
    // Extract user details with default values to avoid nulls
    final String profileImage = widget.user['profileImage'] ?? 'assets/default_profile.png';
    final String name = widget.user['name'] ?? 'Nombre no disponible';
    final String email = widget.user['email'] ?? 'Email no disponible';

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
                    backgroundImage: profileImage.startsWith('http')
                        ? NetworkImage(profileImage)
                        : AssetImage(profileImage) as ImageProvider,
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
            Text(name, style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 20)),
            Text(email, style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),
            MenuItem(
              icon: Icons.build,
              title: 'Servicios',
              onTap: () {
                setState(() {
                  _isOptionSelected1 = !_isOptionSelected1;
                });
                _resetSelectionAfterDelay();
                _navigateToServicesPage();
              },
            ),
            MenuItem(
              icon: Icons.lock,
              title: 'Cambiar contraseña',
              onTap: () {
                setState(() {
                  _isOptionSelected2 = !_isOptionSelected2;
                });
                _resetSelectionAfterDelay();
                _navigateToChangePasswordPage();
              },
            ),
            MenuItem(
              icon: Icons.credit_card,
              title: 'Información de Cobro',
              onTap: () {
                setState(() {
                  _isOptionSelected3 = !_isOptionSelected3;
                });
                _resetSelectionAfterDelay();
                _navigateToBillingInfoPage();
              },
            ),
            MenuItem(
              icon: Icons.logout,
              title: 'Cerrar Sesión',
              onTap: () {
                setState(() {
                  _isOptionSelected4 = true;
                  _isLoggingOut = true;
                });
                _resetSelectionAfterDelay();
                _showLogoutConfirmationDialog();
              },
            ),
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
        return LogoutConfirmationDialog(onConfirm: _logout);
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


