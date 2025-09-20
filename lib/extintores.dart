import 'package:flutter/material.dart';

class ExtintorDetailsPage extends StatefulWidget {
  final String company;
  final String qrData;

  const ExtintorDetailsPage({
    super.key,
    required this.company,
    required this.qrData,
  });

  @override
  State<ExtintorDetailsPage> createState() => _ExtintorDetailsPageState();
}

class _ExtintorDetailsPageState extends State<ExtintorDetailsPage> {
  final List<String> observaciones = [
    'Presión',
    'Manómetro',
    'Etiqueta ilegible',
    'Manguera',
    'Correcto estado',
    'SEGURO CONFORME',
    'SELLO GARANTIA',
    'MANIJA',
    'SEÑALIZACIÓN',
    'TIENE COLLARIN (PQS)',
    'CILINDRO SIN GOLPES',
    'SOPORTE CONFORME',
    'ALTURA MAX. 1.5 M',
    'UBICACIÓN LIBRE Y FÁCIL ACCESO',
    'RUEDAS',
    'COLOCADO',
  ];

  final Set<String> seleccionadas = {};
  final TextEditingController observacionController = TextEditingController();

  @override
  void dispose() {
    observacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extintor - ${widget.company}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Código escaneado: ${widget.qrData}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Selecciona las observaciones:'),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: observaciones.map((obs) {
                  final selected = seleccionadas.contains(obs);
                  return CheckboxListTile(
                    title: Text(obs),
                    value: selected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          seleccionadas.add(obs);
                        } else {
                          seleccionadas.remove(obs);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Observación adicional:'),
            const SizedBox(height: 8),
            TextField(
              controller: observacionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Escribe aquí cualquier observación adicional...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final observacionesTexto = seleccionadas.join(", ");
                final adicional = observacionController.text.trim();

                final mensaje = adicional.isEmpty
                    ? 'Observaciones registradas: $observacionesTexto'
                    : 'Observaciones registradas: $observacionesTexto\nAdicional: $adicional';

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(mensaje)),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
