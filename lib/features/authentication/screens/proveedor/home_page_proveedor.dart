import 'package:flutter/material.dart';

class HomePageProveedor extends StatefulWidget {
  @override
  _HomePageProveedorState createState() => _HomePageProveedorState();
}

class _HomePageProveedorState extends State<HomePageProveedor> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6286CB),
        title: Text(
          _selectedIndex == 0 ? 'Pagos' : _selectedIndex == 1 ? 'Reservaciones' : 'Perfil',
          style: TextStyle(color: Colors.white, fontFamily: 'Mont-Bold', fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat, color: Colors.white),
            onPressed: () {
              // Implementar lógica para abrir el chat
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Implementar lógica para abrir las notificaciones
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Contenido de la página de proveedor',
          style: TextStyle(fontFamily: 'Mont-Bold', fontSize: 20),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF6286CB),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedIndex == 0 ? Colors.white.withOpacity(0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.payment, size: _selectedIndex == 0 ? 36 : 30),
            ),
            label: 'Pagos',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedIndex == 1 ? Colors.white.withOpacity(0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.book, size: _selectedIndex == 1 ? 36 : 30),
            ),
            label: 'Reservaciones',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedIndex == 2 ? Colors.white.withOpacity(0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person, size: _selectedIndex == 2 ? 36 : 30),
            ),
            label: 'Perfil',
          ),
        ],
        selectedLabelStyle: TextStyle(fontFamily: 'Mont-Bold', fontSize: 16),
        unselectedLabelStyle: TextStyle(fontFamily: 'Mont-Bold', fontSize: 14),
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 5,
      ),
    );
  }
}


