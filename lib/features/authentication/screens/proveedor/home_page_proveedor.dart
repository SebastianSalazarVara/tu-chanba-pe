import 'package:flutter/material.dart';
import 'package:tuchanbape/features/authentication/screens/proveedor/reservaciones_page.dart';
import 'perfil_page.dart';  // Importa PerfilPage

class HomePageProveedor extends StatefulWidget {
  final int initialIndex;
  final Map<String, dynamic> user;

  HomePageProveedor({this.initialIndex = 0, required this.user});

  @override
  _HomePageProveedorState createState() => _HomePageProveedorState();
}

class _HomePageProveedorState extends State<HomePageProveedor> {
  late int _selectedIndex;
  late Map<String, dynamic> _user;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _user = widget.user;
    _pages = [
      ReservacionesPage(user: widget.user),
      PerfilPage(user: widget.user), // Aquí puedes usar widget.user
    ];
  }

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
          _selectedIndex == 0 ? 'Reservaciones' : 'Perfil',
          style: TextStyle(color: Colors.white, fontFamily: 'Mont-Bold', fontSize: 24),
        ),
        automaticallyImplyLeading: false, // Aquí se elimina la flecha de retroceso
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages.map((page) {
          if (page is PerfilPage) {
            return PerfilPage(user: _user);
          }
          return page;
        }).toList(),
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
              child: Icon(Icons.book, size: _selectedIndex == 0 ? 36 : 30),
            ),
            label: 'Reservaciones',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedIndex == 1 ? Colors.white.withOpacity(0.4) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.person, size: _selectedIndex == 1 ? 36 : 30),
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
