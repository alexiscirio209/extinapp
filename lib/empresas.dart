import 'package:flutter/material.dart';

class EmpresasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selecciona una empresa')),
      body: const CompanySelector(),
    );
  }
}

class CompanySelector extends StatelessWidget {
  const CompanySelector({super.key});

  final List<String> companies = const [
    'Empresa A',
    'Empresa B',
    'Empresa C',
    'Empresa D',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final selectedCompany = companies[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(selectedCompany),
            subtitle: Text('Selecciona una acción'),
            trailing: Wrap(
              spacing: 12,
              children: [
                IconButton(
                  icon: const Icon(Icons.qr_code),
                  tooltip: 'Escanear QR',
                  onPressed: () {
                    // Navegar al lector QR
                    Navigator.pushNamed(context, '/qrScanner', arguments: selectedCompany);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.list_alt),
                  tooltip: 'Ver listado de extintores',
                  onPressed: () {
                    // Navegar al listado de extintores
                    Navigator.pushNamed(context, '/extintoresList', arguments: selectedCompany);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}