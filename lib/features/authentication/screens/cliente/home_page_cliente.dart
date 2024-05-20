import 'package:flutter/material.dart';
import 'servicios_page.dart';
import 'reservaciones_page.dart';
import 'perfil_page.dart';

class HomePageCliente extends StatefulWidget {
  final int initialIndex;

  HomePageCliente({this.initialIndex = 0});

  @override
  _HomePageClienteState createState() => _HomePageClienteState();
}

class _HomePageClienteState extends State<HomePageCliente> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  static List<Widget> _pages = <Widget>[
    ServiciosPage(),
    ReservacionesPage(),
    PerfilPage(),
  ];

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
          _selectedIndex == 0 ? 'Servicios' : _selectedIndex == 1 ? 'Reservaciones' : 'Perfil',
          style: TextStyle(color: Colors.white, fontFamily: 'Mont-Bold'),
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF6286CB),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _selectedIndex == 0 ? Colors.white30 : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.business, size: _selectedIndex == 0 ? 36 : 30),
            ),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _selectedIndex == 1 ? Colors.white30 : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.book, size: _selectedIndex == 1 ? 36 : 30),
            ),
            label: 'Reservaciones',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _selectedIndex == 2 ? Colors.white30 : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.person, size: _selectedIndex == 2 ? 36 : 30),
            ),
            label: 'Perfil',
          ),
        ],
        selectedLabelStyle: TextStyle(fontFamily: 'Mont-Bold', fontSize: 18),
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




