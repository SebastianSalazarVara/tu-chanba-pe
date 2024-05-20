import 'package:flutter/material.dart';
import 'features/authentication/screens/cliente/perfil_page.dart';
import 'features/authentication/screens/login_page.dart';
import 'features/authentication/screens/forgot_password_page.dart';
import 'features/authentication/screens/register_page.dart'; // Asegúrate de importar PerfilPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chamba PE',
      theme: ThemeData(
        fontFamily: 'Mont',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Mont'),
          bodyMedium: TextStyle(fontFamily: 'Mont'),
          bodySmall: TextStyle(fontFamily: 'Mont'),
          headlineLarge: TextStyle(fontFamily: 'Mont'),
          headlineMedium: TextStyle(fontFamily: 'Mont'),
          headlineSmall: TextStyle(fontFamily: 'Mont'),
          displayLarge: TextStyle(fontFamily: 'Mont'),
          displayMedium: TextStyle(fontFamily: 'Mont'),
          displaySmall: TextStyle(fontFamily: 'Mont'),
          titleLarge: TextStyle(fontFamily: 'Mont'),
          titleMedium: TextStyle(fontFamily: 'Mont'),
          titleSmall: TextStyle(fontFamily: 'Mont'),
          labelLarge: TextStyle(fontFamily: 'Mont'),
          labelMedium: TextStyle(fontFamily: 'Mont'),
          labelSmall: TextStyle(fontFamily: 'Mont'),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/register': (context) => RegisterPage(),
        '/perfil': (context) => PerfilPage(),  // Añadir la ruta para PerfilPage
      },
    );
  }
}


