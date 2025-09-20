import 'package:flutter/material.dart';
import 'login.dart';
import 'empresas.dart';
import 'registro.dart';
import 'option2.dart'; // contiene ExtintoresListPage y ObservacionFormPage
import 'qr_scanner.dart'; // contiene QRScannerPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extintores App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/empresas': (context) => const EmpresasPage(),
        '/registro': (context) => const RegistroPage(),

        // Listado de extintores por empresa
        '/extintoresList': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is String) {
            return ExtintoresListPage(empresa: args);
          } else {
            return const Scaffold(body: Center(child: Text('Empresa no válida')));
          }
        },

        // Formulario para completar observaciones
        '/observacionForm': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return ObservacionFormPage(extintor: args);
          } else {
            return const Scaffold(body: Center(child: Text('Datos de extintor no válidos')));
          }
        },

        // Escáner QR
        '/qrScanner': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is String) {
            return QRScannerPage(empresa: args);
          } else {
            return const Scaffold(body: Center(child: Text('Empresa no válida')));
          }
        },
      },
    );
  }
}