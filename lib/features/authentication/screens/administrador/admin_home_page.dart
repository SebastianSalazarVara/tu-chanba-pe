import 'package:flutter/material.dart';
import 'package:tuchanbape/features/authentication/screens/login_page.dart';
import '../../../../common_widgets/LogoutConfirmationDialog.dart';
import '../../../../common_widgets/MenuItem.dart';
import '../../../../common_widgets/TopBar.dart';
import 'PaymentMethodPage.dart';
import 'category_page.dart';
import 'coverage_area_page.dart'; // Asegúrate de importar la página de categorías

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  bool _isLoggingOut = false;

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutConfirmationDialog(
          onConfirm: _logout,
        );
      },
    ).then((_) {
      setState(() {
        _isLoggingOut = false;
      });
    });
  }

  void _logout() {
    setState(() {
      _isLoggingOut = true;
    });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Inicio'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jonathan Mamani',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Mont-Bold',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'JonathanM@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontFamily: 'Mont-Bold',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MenuItem(
                  icon: Icons.category,
                  title: 'Categorías',
                  onTap: () {
                    // Navega a la página de Categorías
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.location_on,
                  title: 'Área de Cobertura',
                  onTap: () {
                    // Navega a la página de Área de Cobertura
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoverageAreaPage(),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.monetization_on,
                  title: 'Métodos de Cobro',
                  onTap: () {
                    // Navega a la página de Métodos de Cobro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentMethodPage(paymentMethod: 'Métodos de Cobro'),
                      ),
                    );
                  },
                ),
                MenuItem(
                  icon: Icons.exit_to_app,
                  title: 'Cerrar Sesión',
                  onTap: _showLogoutConfirmationDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

